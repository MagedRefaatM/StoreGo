import 'package:store_go/login/model/entities/login_response_data.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class LoginPresenter {
  void verifyingLoginConstrains(Function successFunction) {
    if (LoginLocalData.userEmail.isEmpty &&
            LoginLocalData.userPassword.isEmpty ||
        LoginLocalData.userEmail.isEmpty ||
        LoginLocalData.userPassword.isEmpty) {
      LoginLocalData.loginMessage = 'قم بإدخال إيميل المتجر الخاص والرقم السرى';
    } else if (!LoginLocalData.userEmail.trim().contains('@'))
      LoginLocalData.loginMessage = 'قم بإدخال إيميل المتجر بطريقة صحيحة';
    else if (LoginLocalData.userPassword.length < 8)
      LoginLocalData.loginMessage = 'الرقم السرى قصير جدا';
    else
      successFunction();
  }

  String unAuthorizedLogin() {
    return 'حدث خطأ ما برجاء التأكد من الإيميل المدخل و الرقم السرى';
  }

  String networkFailure() {
    return 'برجاء التأكد من اتصال الانترنت لديك';
  }

  void loginCallSuccessCheck(
      bool loginPassed,
      bool networkCallPassed,
      Function onLoginPassed,
      Function onLoginFailed,
      Function onNetworkError,
      LoginResponseData loginResponse) {
    if (loginPassed) {
      LoginLocalData.userName = loginResponse.name;
      LoginLocalData.userId = loginResponse.id.toString();
      LoginLocalData.userImageLink = loginResponse.image;
      LoginLocalData.userToken = loginResponse.token;
      LoginLocalData.sureBillAppSecret = loginResponse.sureBillAppSecret;
      LoginLocalData.sureBillAppId = loginResponse.sureBillAppId;
      onLoginPassed();
    } else if (!networkCallPassed) {
      onNetworkError();
    } else
      onLoginFailed();
  }
}
