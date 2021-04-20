import 'package:store_go/settings/model/entities/manager_profile_response.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class MyInfoLocalData {
  String updateManagerProfileLink =
      'https://dev.storego.io/api/v1/update-manager';
  String uploadImagesServiceLink = 'https://dev.storego.io/api/v1/upload-file';
  String deleteImageServiceLink = 'https://dev.storego.io/api/v1/delete-file';
  String logoutServiceLink = 'https://dev.storego.io/api/v1/manager-logout';
  String loggedInAcceptLanguage;
  String loggedInUserToken;
  String updateMessage;

  static Data managerProfileInfo;

  static bool networkConnectionState;
  static bool passwordChangeState;
  static bool imageUploadedState;
  static bool imageDeleteState;
  static bool updateState;

  MyInfoLocalData() {
    loggedInAcceptLanguage = LoginLocalData.loginAcceptLanguage;
    loggedInUserToken = LoginLocalData.userToken;
  }
}
