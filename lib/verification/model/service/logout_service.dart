import 'package:store_go/verification/model/data/verification_local_data.dart';
import 'package:store_go/login/model/entities/logout_response_data.dart';
import 'package:http/http.dart';
import 'dart:async';

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
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        VerificationLocalData.networkConnectionPass = true;
        logoutResponse = logoutResponseDataFromJson(response.body);
        return logoutResponse.message;
      } else {
        VerificationLocalData.networkConnectionPass = false;
        return null;
      }
    } on TimeoutException catch (_) {
      VerificationLocalData.networkConnectionPass = false;
    }
  }
}
