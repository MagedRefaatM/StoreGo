import 'package:store_go/settings/model/entities/manager_settings_response.dart';
import 'package:store_go/settings/model/entities/manager_profile_response.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class SettingsLocalData {
  String userLoggedInAcceptLanguage;
  String managerCategoryLink =
      'https://dev.storego.io/api/v1/manager-product-categories';
  String managerSettingsLink = 'https://dev.storego.io/api/v1/manager-settings';
  String managerProfileLink = 'https://dev.storego.io/api/v1/manager-profile';
  String logoutServiceLink = 'https://dev.storego.io/api/v1/manager-logout';
  String userLoggedInToken;

  static bool managerSettingsApiCalled = false;
  static bool networkConnectionState;

  static ManagerSettingsResponse managerSettings;
  static Data managerProfile;

  SettingsLocalData() {
    userLoggedInAcceptLanguage = LoginLocalData.loginAcceptLanguage;
    userLoggedInToken = LoginLocalData.userToken;
  }
}
