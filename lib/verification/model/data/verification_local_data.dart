import 'package:store_go/login/model/data/login_local_data.dart';

class VerificationLocalData {
  String accountInfoServiceLink =
      'https://sandbox-bills.surepay.sa/api/v1/account/information';
  String banksCategoryServiceLink =
      'https://sandbox-bills.surepay.sa/api/v1/banks';
  String logoutServiceLink = 'https://dev.storego.io/api/v1/manager-logout';
  String userLoggedInLanguage;
  String userLoggedInToken;
  String userLoggedInApplicationId;
  String userLoggedInApplicationSecret;

  static bool networkConnectionPass;
  static bool dataConnectionPass;

  VerificationLocalData() {
    userLoggedInApplicationSecret = LoginLocalData.sureBillAppSecret;
    userLoggedInApplicationId = LoginLocalData.sureBillAppId;
    userLoggedInLanguage = LoginLocalData.loginAcceptLanguage;
    userLoggedInToken = LoginLocalData.userToken;
  }
}
