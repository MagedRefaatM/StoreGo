import 'package:store_go/settings/model/entities/display_settings_model.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class DisplaySettingsLocalData {
  static DisplaySettingsModel displaySettingsModel;

  static bool networkConnectionState;
  static bool imageUploadState;
  static bool updateState;

  static String updateStoreServiceLink =
      'https://dev.storego.io/api/v1/update-store';
  static String uploadFileServiceLink =
      'https://dev.storego.io/api/v1/upload-file';
  static String submittedString;
  static String hintMessage;

  static int currentTextFieldId;

  String userLoggedInToken;

  DisplaySettingsLocalData() {
    userLoggedInToken = LoginLocalData.userToken;
  }
}
