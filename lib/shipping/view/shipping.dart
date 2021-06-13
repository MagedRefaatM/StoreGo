import 'package:store_go/settings/model/entities/manager_settings_response.dart';
import 'package:store_go/shipping/model/service/update_store_shipping.dart';
import 'package:store_go/shipping/model/data/shipping_local_data.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:store_go/shipping/presenter/shipping_presenter.dart';
import 'package:store_go/dialogs/exit_edit_product_dialog.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:store_go/text_field_drawer.dart';
import 'package:toast/toast.dart';

class Shipping extends StatefulWidget {
  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  final _updateStoreShipping = UpdateStoreShipping();
  final _loadingKey = GlobalKey<State>();
  final _presenter = ShippingPresenter();

  ShippingPriceList singleShippingListItem;
  ShippingLocalData localData;

  List<ShippingPriceList> deleteListItems = [];
  List<ShippingPriceList> additionalAreasList = [];
  List<ShippingPriceList> finalAreasList = [];
  List<ShippingPriceList> finalAdditionalList = [];

  bool isStateToggleChecked;

  @override
  void initState() {
    localData = ShippingLocalData();

    isStateToggleChecked = _presenter.getShippingState(int.parse(
        ShippingLocalData.shippingModel.shippingEnableState.toString()));
    ShippingLocalData.updateOccurred = false;

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
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(13.0)),
                        ),
                        onPressed: () {
                          _presenter.handleToggleOpacity(
                              isStateToggleChecked,
                              ShippingLocalData
                                  .shippingModel.shippingAreas.length,
                              additionalAreasList.length,
                              () => onNoAreasAdded(),
                              () => onToggleStateClosed(),
                              () => setState(() => additionalAreasList.length =
                                  additionalAreasList.length + 1));
                        },
                        child: Text(
                          'إضافة منطقة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.deepPurpleAccent,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Text(
                      'الشحن',
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'ArabicUiDisplay',
                          fontSize: 24.0,
                          color: Colors.black),
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey[500],
                          size: 40.0,
                        ),
                        onTap: () => _presenter.handleScreenBackPress(
                            ShippingLocalData.updateOccurred,
                            () => Navigator.pop(context),
                            () =>
                                ExitEditProductDialog.showExitEditProductDialog(
                                    context, () => restoreOccurredChanges())))
                  ],
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'تعيين أسعار الشحن',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'ArabicUiDisplay',
                          color: Colors.grey[900]),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(width: 10.0),
                    FlutterSwitch(
                      value: isStateToggleChecked,
                      activeColor: Colors.grey[300],
                      inactiveColor: Colors.deepPurpleAccent,
                      onToggle: (val) {
                        setState(() {
                          isStateToggleChecked = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Opacity(
                  opacity:
                      _presenter.getShippingOpacityAmount(isStateToggleChecked),
                  child: IgnorePointer(
                    ignoring:
                        _presenter.getInteractionState(isStateToggleChecked),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        inflateShippingAreasList(),
                        inflateAdditionalAreasList()
                      ],
                    ),
                  ),
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
                      onPressed: updateStoreShipping,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text('حفظ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w700,
                            )),
                      )),
                )
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
      itemCount: ShippingLocalData.shippingModel.shippingAreas.length ?? 0,
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
                      hintText: "السعر",
                      labelFontSize: 17.0,
                      labelText: ShippingLocalData
                          .shippingModel.shippingAreas[index].price,
                    )),
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
                      hintText: "اسم المنطقة",
                      labelFontSize: 17.0,
                      labelText: ShippingLocalData
                          .shippingModel.shippingAreas[index].name,
                    )),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.clear, color: Colors.white),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                    onTap: () {
                      deleteListItems.add(
                          ShippingLocalData.shippingModel.shippingAreas[index]);
                      _presenter.handleDecreasingShippingAreasLength(
                          ShippingLocalData.shippingModel.shippingAreas.length,
                          () => deleteAreasListItems(index,
                              ShippingLocalData.shippingModel.shippingAreas),
                          () => deleteLastIndex(index,
                              ShippingLocalData.shippingModel.shippingAreas));
                    },
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
      itemCount: additionalAreasList.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        singleShippingListItem = ShippingPriceList();
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
                      hintText: "السعر",
                      onChange: (String value) => priceTextHandler(value),
                      onSubmitted: (String value) => priceTextHandler(value),
                    )),
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
                      hintText: "اسم المنطقة",
                      onChange: (String value) => areaTextHandler(value),
                      onSubmitted: (String value) => areaTextHandler(value),
                    )),
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
                      finalAdditionalList.removeAt(index);
                      additionalAreasList.removeAt(index);
                      _presenter.checkMainListLength(
                          ShippingLocalData.shippingModel.shippingAreas.length,
                          () => setState(() =>
                              isStateToggleChecked = !isStateToggleChecked));
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

  priceTextHandler(String price) {
    singleShippingListItem.price = price;
    _presenter.fillAdditionalAreasList(
        singleShippingListItem,
        () => finalAdditionalList.add(singleShippingListItem),
        finalAdditionalList);
  }

  areaTextHandler(String area) {
    singleShippingListItem.name = area;
    _presenter.fillAdditionalAreasList(
        singleShippingListItem,
        () => finalAdditionalList.add(singleShippingListItem),
        finalAdditionalList);
  }

  onNoAreasAdded() => setState(() {
        isStateToggleChecked = false;
        additionalAreasList.length += 1;
      });

  onToggleStateClosed() => setState(() {
        localData.toastMessage = 'قم بتفعيل خاصية الشحن اولا';
        showToast();
      });

  deleteAreasListItems(int index, List<ShippingPriceList> workingOnList) =>
      setState(() => workingOnList.removeAt(index));

  deleteLastIndex(int index, List<ShippingPriceList> workingOnList) =>
      _presenter.handleDeleteListIndex(
          ShippingLocalData.shippingModel.shippingAreas,
          additionalAreasList,
          () => deleteAreasListItems(index, workingOnList),
          () => bothListsEmpty(index, workingOnList));

  bothListsEmpty(int index, List<ShippingPriceList> list) => setState(() {
        list.removeAt(index);
        isStateToggleChecked = true;
      });

  restoreOccurredChanges() => _presenter.handleListElementsRestore(
      deleteListItems,
      ShippingLocalData.shippingModel.shippingAreas,
      () => onNoDeleteOccurred(),
      () => onSingleItemDeleted(),
      () => onAllItemsDeleted());

  onSingleItemDeleted() {
    ShippingLocalData.shippingModel.shippingAreas.addAll(deleteListItems);
    Navigator.of(context).pop();
    Navigator.pop(context);
  }

  onAllItemsDeleted() {
    ShippingLocalData.shippingModel.shippingAreas.addAll(deleteListItems);
    Navigator.of(context).pop();
    Navigator.pop(context);
  }

  onNoDeleteOccurred() {
    Navigator.of(context).pop();
    Navigator.pop(context);
  }

  updateStoreShipping() {
    finalAreasList.clear();
    finalAreasList.addAll(ShippingLocalData.shippingModel.shippingAreas);
    finalAreasList.addAll(finalAdditionalList);

    ShippingLocalData.updateOccurred = true;
    LoadingDialog.showLoadingDialog(context, _loadingKey);
    _updateStoreShipping
        .getUpdateResponse(
            localData.updateStoreServiceLink,
            localData.loggedInUserToken,
            _presenter.getStoreState(isStateToggleChecked),
            finalAreasList)
        .then((value) => _presenter.serviceCallHandler(
            ShippingLocalData.networkConnectionState,
            ShippingLocalData.updateState,
            () => successStoreUpdate(),
            () => dataFailure(),
            () => connectionTimeOut()));
  }

  successStoreUpdate() {
    Navigator.of(context).pop();
    localData.toastMessage = 'تم الحفظ';
    showToast();
    updateManagerSettingsModel();
  }

  updateManagerSettingsModel() {
    SettingsLocalData.managerSettings.data.enableShippingPriceList =
        _presenter.getStoreState(isStateToggleChecked).toString();
    SettingsLocalData.managerSettings.data.shippingPriceList = finalAreasList;
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

  void showToast() {
    Toast.show(localData.toastMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }
}
