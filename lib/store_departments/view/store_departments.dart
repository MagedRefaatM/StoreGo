import 'package:store_go/store_departments/model/service/update_store_departments.dart';
import 'package:store_go/store_departments/presenter/store_departments_presenter.dart';
import 'package:store_go/settings/model/entities/manager_category_response.dart';
import 'package:store_go/store_departments/model/data/category_local_data.dart';
import 'package:store_go/dialogs/exit_edit_product_dialog.dart';
import 'package:store_go/drawers//text_field_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class StoreDepartments extends StatefulWidget {
  @override
  _StoreDepartmentsState createState() => _StoreDepartmentsState();
}

class _StoreDepartmentsState extends State<StoreDepartments> {
  final _updateManagerCategory = UpdateManagerCategory();
  final _loadingKey = GlobalKey<State>();
  final _presenter = StoreDepartmentsPresenter();

  Datum singleCategoryItem;
  ManagerCategoryLocalData localData;

  List<Datum> additionalCategoriesList = [];
  List<Datum> finalCategoriesList = [];
  List<Datum> finalAdditionalList = [];
  List<Datum> deleteListItems = [];

  @override
  void initState() {
    localData = ManagerCategoryLocalData();

    ManagerCategoryLocalData.updateOccurred = false;
    ManagerCategoryLocalData.managerCategories.removeAt(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13.0),
                                      side: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 1.5))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(13.0)),
                            ),
                            onPressed: () => setState(() =>
                                additionalCategoriesList.length =
                                    additionalCategoriesList.length + 1),
                            child: TextDrawer(
                                text: 'إضافة منطقة',
                                textAlign: TextAlign.center,
                                fontSize: 18.0,
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.w500))),
                    TextDrawer(
                        text: 'أقسام المتجر',
                        maxLines: 1,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0,
                        color: Colors.black),
                    SizedBox(width: 5.0),
                    GestureDetector(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey[500],
                          size: 40.0,
                        ),
                        onTap: () => _presenter.handleScreenBackPress(
                            ManagerCategoryLocalData.updateOccurred,
                            () => Navigator.pop(context),
                            () =>
                                ExitEditProductDialog.showExitEditProductDialog(
                                    context, () => restoreOccurredChanges())))
                  ],
                ),
                SizedBox(height: 50.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    inflateShippingAreasList(),
                    inflateAdditionalAreasList()
                  ],
                ),
                SizedBox(height: 15.0),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.deepPurpleAccent))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white)),
                      ),
                      onPressed: updateStoreCategories,
                      child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: TextDrawer(
                            text: 'حفظ',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ))),
                ),
                SizedBox(height: 20.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inflateShippingAreasList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ManagerCategoryLocalData.managerCategories.length ?? 0,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: TextFieldDrawer(
                        textAlign: TextAlign.center,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.number,
                        maxLines: 1,
                        borderRadius: 5.0,
                        hintFontSize: 17.0,
                        hintText: "الترتيب",
                        labelFontSize: 17.0,
                        labelText: ManagerCategoryLocalData
                            .managerCategories[index].order
                            .toString())),
                SizedBox(width: 10.0),
                Expanded(
                    flex: 4,
                    child: TextFieldDrawer(
                        textAlign: TextAlign.center,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        borderRadius: 5.0,
                        hintFontSize: 17.0,
                        hintText: "اسم القسم",
                        labelFontSize: 17.0,
                        labelText: ManagerCategoryLocalData
                            .managerCategories[index].name)),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.clear, color: Colors.white),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                    onTap: () => deleteOriginalListItem(
                        ManagerCategoryLocalData.managerCategories[index]),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0)
          ],
        );
      },
    );
  }

  Widget inflateAdditionalAreasList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: additionalCategoriesList.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        singleCategoryItem = Datum();
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: TextFieldDrawer(
                        textAlign: TextAlign.left,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.number,
                        maxLines: 1,
                        borderRadius: 5.0,
                        hintFontSize: 17.0,
                        hintText: "الترتيب",
                        onChange: (String value) => rankTextHandler(value),
                        onSubmitted: (String value) => rankTextHandler(value))),
                SizedBox(width: 10.0),
                Expanded(
                    flex: 4,
                    child: TextFieldDrawer(
                        textAlign: TextAlign.left,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        borderRadius: 5.0,
                        hintFontSize: 17.0,
                        hintText: "اسم القسم",
                        onChange: (String value) => categoryTextHandler(value),
                        onSubmitted: (String value) =>
                            categoryTextHandler(value))),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.clear, color: Colors.white),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                    onTap: () => setState(() {
                      additionalCategoriesList.removeAt(index);
                      finalAdditionalList.removeAt(index);
                    }),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0)
          ],
        );
      },
    );
  }

  rankTextHandler(String rank) {
    singleCategoryItem.order = int.parse(rank);
    _presenter.fillAdditionalAreasList(singleCategoryItem,
        () => finalAdditionalList.add(singleCategoryItem), finalAdditionalList);
  }

  categoryTextHandler(String deptName) {
    singleCategoryItem.name = deptName;
    _presenter.fillAdditionalAreasList(singleCategoryItem,
        () => finalAdditionalList.add(singleCategoryItem), finalAdditionalList);
  }

  deleteOriginalListItem(Datum currentDeletedItem) {
    updateItemState(currentDeletedItem);
    deleteListItems.add(currentDeletedItem);
    setState(() =>
        ManagerCategoryLocalData.managerCategories.remove(currentDeletedItem));
  }

  updateItemState(Datum currentDeletedItem) {
    final newDatumItem = ManagerCategoryLocalData.managerCategories
        .firstWhere((item) => item.id == currentDeletedItem.id);
    setState(() => newDatumItem.deleted = true);
  }

  restoreOccurredChanges() => _presenter.handleListElementsRestore(
      deleteListItems,
      ManagerCategoryLocalData.managerCategories,
      () => onNoDeleteOccurred(),
      () => onSingleItemDeleted(),
      () => onAllItemsDeleted());

  onSingleItemDeleted() {
    ManagerCategoryLocalData.managerCategories.addAll(deleteListItems);
    Navigator.of(context).pop();
    Navigator.pop(context);
  }

  onAllItemsDeleted() {
    ManagerCategoryLocalData.managerCategories.addAll(deleteListItems);
    Navigator.of(context).pop();
    Navigator.pop(context);
  }

  onNoDeleteOccurred() {
    Navigator.of(context).pop();
    Navigator.pop(context);
  }

  updateStoreCategories() {
    finalCategoriesList.clear();
    finalCategoriesList.addAll(ManagerCategoryLocalData.managerCategories);
    finalCategoriesList.addAll(finalAdditionalList);
    finalCategoriesList.addAll(deleteListItems);

    ManagerCategoryLocalData.updateOccurred = true;
    LoadingDialog.showLoadingDialog(context, _loadingKey);
    _updateManagerCategory
        .getUpdateResponse(localData.saveManagerCategoriesLink,
            localData.loggedInUserToken, finalCategoriesList)
        .then((value) => _presenter.serviceCallHandler(
            ManagerCategoryLocalData.networkConnectionState,
            ManagerCategoryLocalData.updateState,
            () => successStoreUpdate(),
            () => dataFailure(),
            () => connectionTimeOut()));
  }

  successStoreUpdate() {
    Navigator.of(context).pop();
    localData.toastMessage = 'تم الحفظ';
    showToast();
  }

  dataFailure() {
    Navigator.of(context).pop();
    localData.toastMessage = 'حدث خطأ ما برجاء إعادة المحاولة';
    showToast();
  }

  connectionTimeOut() {
    Navigator.of(context).pop();
    localData.toastMessage = 'برجاء التأكد من وجود اتصال ثابت بالانترنت';
    showToast();
  }

  showToast() {
    Toast.show(localData.toastMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }
}
