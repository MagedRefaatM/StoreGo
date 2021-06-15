import 'package:store_go/store_settings/model/data/store_settings_local_data.dart';
import 'package:store_go/store_settings/model/service/update_store_settings.dart';
import 'package:store_go/store_settings/presenter/store_settings_presenter.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:store_go/drawers/elevated_button_drawer.dart';
import 'package:store_go/drawers//text_field_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class StoreSettings extends StatefulWidget {
  @override
  _StoreSettingsState createState() => _StoreSettingsState();
}

class _StoreSettingsState extends State<StoreSettings> {
  final _storeDescriptionController = TextEditingController();
  final _storeBillNotesController = TextEditingController();
  final _storeBillNameController = TextEditingController();
  final _storeEmailController = TextEditingController();
  final _storeNameController = TextEditingController();
  final _updateStoreSettings = UpdateStoreSettings();
  final _loadingKey = GlobalKey<State>();
  final _presenter = StoreSettingsPresenter();

  StoreSettingsLocalData localData;

  bool isStateToggleChecked;

  @override
  void initState() {
    localData = StoreSettingsLocalData();
    isStateToggleChecked = _presenter.getStoreSettingsState(int.parse(
        StoreSettingsLocalData.storeSettingsModel.storeEnableState.toString()));
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
                    SizedBox(height: 15.0),
                    SizedBox(width: 37),
                    TextDrawer(
                        text: 'إعدادات المتجر',
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        fontWeight: FontWeight.w700,
                        fontSize: 21.0,
                        color: Colors.black),
                    SizedBox(width: 5.0),
                    GestureDetector(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey[500],
                          size: 40.0,
                        ),
                        onTap: () => Navigator.pop(context))
                  ],
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextDrawer(
                        text:
                            '(${_presenter.getCurrentStoreState(isStateToggleChecked)})',
                        maxLines: 1,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                        textAlign: TextAlign.end),
                    SizedBox(width: 5.0),
                    TextDrawer(
                        text: 'تفعيل المتجر',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                        textAlign: TextAlign.end),
                    SizedBox(width: 5.0),
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
                SizedBox(height: 20.0),
                drawStoreSectionsTextField(
                    TextInputAction.next,
                    TextInputType.name,
                    'اسم المتجر',
                    StoreSettingsLocalData.storeSettingsModel.storeName,
                    1,
                    _storeNameController),
                SizedBox(height: 10.0),
                drawStoreSectionsTextField(
                    TextInputAction.next,
                    TextInputType.multiline,
                    'الوصف',
                    StoreSettingsLocalData.storeSettingsModel.storeDescription,
                    4,
                    _storeDescriptionController),
                SizedBox(height: 10.0),
                drawStoreSectionsTextField(
                    TextInputAction.next,
                    TextInputType.name,
                    'اسم المتجرعلى الفاتورة',
                    StoreSettingsLocalData.storeSettingsModel.storeBillName,
                    1,
                    _storeBillNameController),
                SizedBox(height: 10.0),
                drawStoreSectionsTextField(
                    TextInputAction.next,
                    TextInputType.multiline,
                    'ملاحظات المتجر على الفاتورة',
                    StoreSettingsLocalData.storeSettingsModel.storeBillNotes,
                    4,
                    _storeBillNotesController),
                SizedBox(height: 10.0),
                drawStoreSectionsTextField(
                    TextInputAction.done,
                    TextInputType.emailAddress,
                    'عنوان البريد الإلكترونى لإستلام الإشعارات',
                    StoreSettingsLocalData
                        .storeSettingsModel.storeNotificationEmail,
                    1,
                    _storeEmailController),
                SizedBox(height: 15.0),
                ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child:
                        ElevatedButtonDrawer(onPressed: updateStoreSettings)),
                SizedBox(height: 20.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawStoreSectionsTextField(
      TextInputAction inputAction,
      TextInputType inputType,
      String hintString,
      String labelString,
      int maxLines,
      TextEditingController controller) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        child: TextFieldDrawer(
            textAlign: TextAlign.center,
            inputType: inputType,
            inputAction: inputAction,
            controller: controller,
            maxLines: maxLines,
            borderRadius: 5.0,
            hintFontSize: 17.0,
            hintText: hintString,
            labelFontSize: 17.0,
            labelText: labelString,
            floatingLabelBehavior: FloatingLabelBehavior.auto));
  }

  updateStoreSettings() {
    LoadingDialog.showLoadingDialog(context, _loadingKey);
    _updateStoreSettings
        .getUpdateResponse(
            localData.updateStoreServiceLink,
            localData.loggedInUserToken,
            _presenter.getStoreState(isStateToggleChecked),
            _presenter.getTextFieldText(_storeNameController,
                StoreSettingsLocalData.storeSettingsModel.storeName),
            _presenter.getTextFieldText(_storeDescriptionController,
                StoreSettingsLocalData.storeSettingsModel.storeDescription),
            _presenter.getTextFieldText(_storeBillNameController,
                StoreSettingsLocalData.storeSettingsModel.storeBillName),
            _presenter.getTextFieldText(_storeBillNotesController,
                StoreSettingsLocalData.storeSettingsModel.storeBillNotes),
            _presenter.getTextFieldText(
                _storeEmailController,
                StoreSettingsLocalData
                    .storeSettingsModel.storeNotificationEmail))
        .then((updateResponse) => _presenter.serviceCallHandler(
            StoreSettingsLocalData.networkConnectionState,
            StoreSettingsLocalData.updateState,
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
    SettingsLocalData.managerSettings.data.enableStore =
        _presenter.getStoreState(isStateToggleChecked);
    SettingsLocalData.managerSettings.data.name = _presenter.getTextFieldText(
        _storeNameController,
        StoreSettingsLocalData.storeSettingsModel.storeName);
    SettingsLocalData.managerSettings.data.description =
        _presenter.getTextFieldText(_storeDescriptionController,
            StoreSettingsLocalData.storeSettingsModel.storeDescription);
    SettingsLocalData.managerSettings.data.billName =
        _presenter.getTextFieldText(_storeBillNameController,
            StoreSettingsLocalData.storeSettingsModel.storeBillName);
    SettingsLocalData.managerSettings.data.billNotes =
        _presenter.getTextFieldText(_storeBillNotesController,
            StoreSettingsLocalData.storeSettingsModel.storeBillNotes);
    SettingsLocalData.managerSettings.data.notificationEmail =
        _presenter.getTextFieldText(_storeEmailController,
            StoreSettingsLocalData.storeSettingsModel.storeNotificationEmail);
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

  @override
  void dispose() {
    _storeEmailController.dispose();
    _storeBillNotesController.dispose();
    _storeBillNameController.dispose();
    _storeDescriptionController.dispose();
    _storeNameController.dispose();
    super.dispose();
  }
}
