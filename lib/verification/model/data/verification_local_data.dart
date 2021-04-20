import 'package:store_go/login/model/data/login_local_data.dart';

class VerificationLocalData {
  String logoutServiceLink = 'https://dev.storego.io/api/v1/manager-logout';
  String userLoggedInLanguage;
  String userLoggedInToken;

  static bool networkConnectionPass;

  VerificationLocalData() {
    userLoggedInLanguage = LoginLocalData.loginAcceptLanguage;
    userLoggedInToken = LoginLocalData.userToken;
  }
}
