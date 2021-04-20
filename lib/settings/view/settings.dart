import 'package:store_go/display_settings/model/data/display_settings_local_data.dart';
import 'package:store_go/store_settings/model/data/store_settings_local_data.dart';
import 'package:store_go/settings/model/entities/manager_category_response.dart';
import 'package:store_go/store_departments/model/data/category_local_data.dart';
import 'package:store_go/settings/model/entities/manager_profile_response.dart';
import 'package:store_go/settings/model/entities/display_settings_model.dart';
import 'package:store_go/settings/model/entities/store_settings_model.dart';
import 'package:store_go/settings/model/service/get_manager_settings.dart';
import 'package:store_go/settings/model/service/get_manager_category.dart';
import 'package:store_go/settings/model/service/get_manager_profile.dart';
import 'package:store_go/settings/model/service/logout_api_service.dart';
import 'package:store_go/login/model/entities/logout_response_data.dart';
import 'package:store_go/store_departments/view/store_departments.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:store_go/shipping/model/data/shipping_local_data.dart';
import 'package:store_go/settings/model/entities/shipping_model.dart';
import 'package:store_go/display_settings/view/display_settings.dart';
import 'package:store_go/my_info/model/data/my_info_local_data.dart';
import 'package:store_go/settings/presenter/settings_presenter.dart';
import 'package:store_go/settings/model/entities/single_option.dart';
import 'package:store_go/settings/model/entities/taxes_model.dart';
import 'package:store_go/store_settings/view/store_settings.dart';
import 'package:store_go/taxes/model/data/taxes_local_data.dart';
import 'package:store_go/settings/view/settings_tab.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/shipping/view/shipping.dart';
import 'package:store_go/my_info/view/my_info.dart';
import 'package:store_go/dialogs/exit_dialog.dart';
import 'package:store_go/taxes/view/taxes.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _getManagerCategories = GetManagerCategories();
  final _getManagerSettings = ManagerSettingsService();
  final _getManagerProfile = ManagerProfileService();
  final _getLogoutResponse = LogoutAPIService();
  final _loadingDialogKey = new GlobalKey<State>();
  final _presenter = SettingsPresenter();

  final _options = [
    SingleOption('معلوماتى', Icons.arrow_back_ios_sharp, 1),
    SingleOption('إعدادات المتجر', Icons.arrow_back_ios_sharp, 2),
    SingleOption('الضرائب', Icons.arrow_back_ios_sharp, 3),
    SingleOption('الشحن', Icons.arrow_back_ios_sharp, 4),
    SingleOption('أقسام المتجر', Icons.arrow_back_ios_sharp, 5),
    SingleOption('إعدادات المظهر', Icons.arrow_back_ios_sharp, 6),
    SingleOption('تسجيل الخروج', Icons.add_to_home_screen, 7),
  ];

  SettingsLocalData localData;

  @override
  void initState() {
    localData = SettingsLocalData();
    SettingsLocalData.managerSettingsApiCalled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.0),
              Expanded(
                flex: 1,
                child: Text(
                  'الإعدادات',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'ArabicUiDisplay',
                      fontSize: 26.0,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 15.0),
              Expanded(
                flex: 14,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _options
                            .map((option) => SettingsTab(
                          settingName: option.name,
                          settingIcon: option.icon,
                          settingHandler: () => _presenter.settingsHandler(
                              option.id,
                                  () => onMyInfoClicked(),
                                  () => onManagerSettingsClicked(option.id),
                                  () => onStoreDepartmentsClicked(),
                                  () => ExitDialog.showExitDialog(
                                      context, () => onLogoutClicked())),
                        ))
                            .toList()),
                  ),
                ),
              )
            ],
          )),
    );
  }

  onMyInfoClicked() {
    LoadingDialog.showLoadingDialog(context, _loadingDialogKey);
    _getManagerProfile
        .getManagerProfileInfo(
            localData.managerProfileLink, localData.userLoggedInToken)
        .then((profileResponse) => _presenter.checkConnectionState(
            SettingsLocalData.networkConnectionState,
            () => onConnectionSuccess(1, profileResponse),
            () => onConnectionError()));
  }

  //ManagerSettings consists of 4 Options :
  //1- StoreSettings screen
  //2- Taxes screen
  //3- Shipping screen
  //4- DisplaySettings screen
  onManagerSettingsClicked(int settingId) {
    //check if managerSettings api already called once
    // to avoid multiple calls for the same api
    LoadingDialog.showLoadingDialog(context, _loadingDialogKey);
    _presenter.checkManagerSettingsCallState(
        SettingsLocalData.managerSettingsApiCalled,
        () => getManagerSettingsInformation(settingId),
        () => onConnectionSuccess(
            settingId, _presenter.returnCorrectSettingModel(settingId)));
  }

  getManagerSettingsInformation(int settingId) {
    _getManagerSettings
        .getManagerSettingsInfo(
            localData.managerSettingsLink, localData.userLoggedInToken)
        .then((managerResponse) {
      SettingsLocalData.managerSettings = managerResponse;
      _presenter.checkConnectionState(
          SettingsLocalData.networkConnectionState,
          () => onConnectionSuccess(
              settingId, _presenter.returnCorrectSettingModel(settingId)),
          () => onConnectionError());
    });
  }

  onStoreDepartmentsClicked() {
    LoadingDialog.showLoadingDialog(context, _loadingDialogKey);
    _getManagerCategories
        .getUpdateResponse(
            localData.managerCategoryLink,
            localData.userLoggedInToken,
            localData.userLoggedInAcceptLanguage,
            '',
            '')
        .then((categoriesResponse) => _presenter.checkConnectionState(
            SettingsLocalData.networkConnectionState,
            () => onConnectionSuccess(5, categoriesResponse),
            () => onConnectionError()));
  }

  onLogoutClicked() {
    LoadingDialog.showLoadingDialog(context, _loadingDialogKey);
    _getLogoutResponse
        .getLogoutResponse(localData.logoutServiceLink,
            localData.userLoggedInAcceptLanguage, localData.userLoggedInToken)
        .then((logoutResponse) => _presenter.checkConnectionState(
            SettingsLocalData.networkConnectionState,
            () => onConnectionSuccess(7, logoutResponse),
            () => onConnectionError()));
  }

  void onConnectionSuccess(int settingId, dynamic callResponse) {
    Navigator.of(context).pop();
    _presenter.settingsConnectionSuccessHandler(
        settingId,
        () => onProfileReady(callResponse),
        () => onSettingsInfoReady(callResponse),
        () => onTaxesInfoReady(callResponse),
        () => onShippingInfoReady(callResponse),
        () => onDepartmentsInfoReady(callResponse),
        () => onDisplayInfoReady(callResponse),
        () => onLogoutSuccess(callResponse));
  }

  onProfileReady(ManagerProfileGetResponse response) {
    MyInfoLocalData.managerProfileInfo = response.data;
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyInfo()));
  }

  onSettingsInfoReady(StoreSettingsModel settingResponse) {
    StoreSettingsLocalData.storeSettingsModel = settingResponse;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => StoreSettings()));
  }

  onTaxesInfoReady(TaxesModel taxesResponse) {
    TaxesLocalData.taxesModel = taxesResponse;
    Navigator.push(context, MaterialPageRoute(builder: (context) => Taxes()));
  }

  onShippingInfoReady(ShippingModel shippingResponse) {
    ShippingLocalData.shippingModel = shippingResponse;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Shipping()));
  }

  onDepartmentsInfoReady(ManagerProductCategory categoryResponse) {
    ManagerCategoryLocalData.managerCategories = categoryResponse.data;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => StoreDepartments()));
  }

  onDisplayInfoReady(DisplaySettingsModel displaySettingsResponse) {
    DisplaySettingsLocalData.displaySettingsModel = displaySettingsResponse;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DisplaySettings()));
  }

  onLogoutSuccess(LogoutResponseData logoutResponse) =>
      Navigator.pushNamedAndRemoveUntil(
          context, '/login_page', (route) => false);

  void onConnectionError() {
    SettingsLocalData.managerSettingsApiCalled = false;
    Navigator.of(_loadingDialogKey.currentContext, rootNavigator: true ?? context).pop();
    Toast.show('برجاء التأكد من إتصال الإنترنت', context,
        duration: 3, gravity: Toast.BOTTOM);
  }
}
