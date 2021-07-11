import '../../../verification/data_layer/data_model/logout_response_data.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class LogoutAPIService {
  Future<LogoutResponseData> getLogoutResponse(
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
        SettingsLocalData.networkConnectionState = true;
        logoutResponse = logoutResponseDataFromJson(response.body);
        return logoutResponse;
      } else {
        SettingsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      SettingsLocalData.networkConnectionState = false;
    }
  }
}
