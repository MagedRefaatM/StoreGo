import 'dart:async';

import 'package:http/http.dart';
import 'file:///C:/Users/maged.refaat/AndroidStudioProjects/store_go/lib/login/model/entities/logout_response_data.dart';

class LogoutAPIService {
  Future<String> getLogoutResponse(
      String loginLink, String logoutLang, String token) async {
    LogoutResponseData logoutResponse;
    String authorizationToken = 'Bearer $token';

    try {
      final response = await post(
        Uri.parse(loginLink),
        headers: <String, String>{
          'accept-language': logoutLang,
          'authorization': authorizationToken
        },
      ).timeout(Duration(seconds: 2));

      print(response.statusCode);

      if (response.statusCode == 200) {
        logoutResponse = logoutResponseDataFromJson(response.body);
        return logoutResponse.message;
      } else {
        return null;
      }
    } on TimeoutException catch(_) {

    }
  }
}
