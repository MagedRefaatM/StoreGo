import 'package:store_go/login/model/entities/login_response_data.dart';
import 'package:store_go/login/model/entities/login_response.dart';
import 'package:store_go/login/model/data/login_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class LoginAPIService {
  Future<LoginResponseData> getLoginResponse(
      String loginLink, String loginLang, String email, String password) async {
    LoginResponse loginResponse;

    try {
      final response = await post(Uri.parse(loginLink),
              headers: <String, String>{'accept-language': loginLang},
              body: <String, String>{'email': email, 'password': password})
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        LoginLocalData.loginPassed = true;
        LoginLocalData.networkConnectionPass = true;

        loginResponse = loginResponseFromJson(response.body);
        return loginResponse.data[0];
      } else {
        LoginLocalData.networkConnectionPass = true;
        LoginLocalData.loginPassed = false;
        return null;
      }
    } on TimeoutException catch (_) {
      LoginLocalData.networkConnectionPass = false;
    }
  }
}
