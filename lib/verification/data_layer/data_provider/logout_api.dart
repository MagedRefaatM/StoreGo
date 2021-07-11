import 'package:store_go/verification/data_layer/data_model/logout_response_data.dart';
import 'package:store_go/login/data_layer/data_model/login_response.dart';
import 'package:store_go/login/shared_pref/shared_pref.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class LogoutApiClient {
  final _logoutEndpoint = 'https://dev.storego.io/api/v1/manager-logout';
  final _logoutLanguage = 'en';
  final _sharedPref = SharedPref();

  Future<dynamic> postLogoutRequest() async {
    var authorizationToken =
        'Brear ${LoginData.fromJson(await _sharedPref.read('loginInfo')).token}';
    try {
      final _callResponse = await post(
        Uri.parse(_logoutEndpoint),
        headers: <String, String>{
          'accept-language': _logoutLanguage,
          'authorization': authorizationToken
        },
      ).timeout(Duration(seconds: 5));

      if (_callResponse.statusCode != 200) return null;

      return LogoutResponseData.fromJson(jsonDecode(_callResponse.body));
    } on TimeoutException catch (_) {
      return 0;
    }
  }
}
