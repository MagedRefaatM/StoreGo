import 'package:store_go/login/model/data/login_local_data.dart';

class VerificationLocalData{
  static String logoutServiceLink = 'https://dev.storego.io/api/v1/manager-logout';
  static String userLoggedInLanguage = LoginLocalData.loginAcceptLanguage;
  static String userLoggedInToken = LoginLocalData.userToken;

  static bool networkConnectionPass;
}