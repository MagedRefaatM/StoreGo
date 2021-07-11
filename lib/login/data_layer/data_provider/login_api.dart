import 'package:store_go/login/data_layer/data_model/login_response.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class LoginApiClient {
  final _loginEndpoint = 'https://dev.storego.io/api/v1/manager-login';
  final _loginLanguage = 'en';

  Future<dynamic> postLoginRequest(String email, String password) async {
    try {
      final _callResponse = await post(Uri.parse(_loginEndpoint),
              headers: <String, String>{'accept-language': _loginLanguage},
              body: <String, String>{'email': email, 'password': password})
          .timeout(Duration(seconds: 5));

      if (_callResponse.statusCode != 200) return null;

      return LoginResponse.fromJson(jsonDecode(_callResponse.body));
    } on TimeoutException catch (_) {
      return 0;
    }
  }
}
