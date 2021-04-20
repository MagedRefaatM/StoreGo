import 'package:store_go/settings/model/entities/store_settings_model.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class StoreSettingsLocalData {
  String updateStoreServiceLink = 'https://dev.storego.io/api/v1/update-store';
  String loggedInUserToken;
  String toastMessage;

  static bool networkConnectionState;
  static bool updateState;

  static StoreSettingsModel storeSettingsModel;

  StoreSettingsLocalData() {
    loggedInUserToken = LoginLocalData.userToken;
  }
}
