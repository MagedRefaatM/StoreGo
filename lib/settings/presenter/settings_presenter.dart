import 'package:store_go/settings/model/entities/display_settings_model.dart';
import 'package:store_go/settings/model/entities/store_settings_model.dart';
import 'package:store_go/settings/model/entities/shipping_model.dart';
import 'package:store_go/settings/model/entities/taxes_model.dart';

class SettingsPresenter {
  void settingsHandler(int settingId, Function myInfo, Function managerSettings,
      Function storeDepartments, Function logout) {
    switch (settingId) {
      case 1:
        myInfo();
        break;

      case 2:
      case 3:
      case 4:
      case 6:
        managerSettings();
        break;

      case 5:
        storeDepartments();
        break;

      case 7:
        logout();
        break;
    }
  }

  void checkManagerSettingsCallState(bool managerEndpointCalledState,
      Function onFirstCalled, Function onInformationExists) {
    if (!managerEndpointCalledState)
      onFirstCalled();
    else
      onInformationExists();
  }

  void settingsConnectionSuccessHandler(
      int settingId,
      Function myInfo,
      Function storeSettings,
      Function taxes,
      Function shipping,
      Function storeDepartments,
      Function displaySettings,
      Function logout) {
    switch (settingId) {
      case 1:
        myInfo();
        break;

      case 2:
        storeSettings();
        break;

      case 3:
        taxes();
        break;

      case 4:
        shipping();
        break;

      case 5:
        storeDepartments();
        break;

      case 6:
        displaySettings();
        break;

      case 7:
        logout();
        break;
    }
  }

  dynamic returnCorrectSettingModel(int optionId) {
    final _storeSettingsResponse = StoreSettingsModel();
    final _taxesResponse = TaxesModel();
    final _shippingResponse = ShippingModel();
    final _displaySettingsResponse = DisplaySettingsModel();

    switch (optionId) {
      case 2:
        return _storeSettingsResponse;
        break;

      case 3:
        return _taxesResponse;
        break;

      case 4:
        return _shippingResponse;
        break;

      case 6:
        return _displaySettingsResponse;
        break;
    }
  }

  void checkConnectionState(
      bool connectionState, Function onSuccess, Function onError) {
    if (connectionState)
      onSuccess();
    else
      onError();
  }
}
