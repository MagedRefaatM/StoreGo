import 'package:store_go/login/model/entities/logout_response_data.dart';
import 'package:store_go/my_info/model/data/my_info_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class LogoutAPIService {
  Future<String> getLogoutResponse(
      String logoutLink, String logoutLang, String token) async {
    LogoutResponseData logoutResponse;
    String authorizationToken = 'Bearer $token';

    try {
      final response = await post(
        Uri.parse(logoutLink),
        headers: <String, String>{
          'accept-language': logoutLang,
          'authorization': authorizationToken
        },
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        MyInfoLocalData.networkConnectionState = true;
        logoutResponse = logoutResponseDataFromJson(response.body);
        return logoutResponse.message;
      } else {
        MyInfoLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      MyInfoLocalData.networkConnectionState = false;
    }
  }
}
