import 'package:store_go/settings/model/entities/manager_settings_response.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class ManagerSettingsService {
  Future<ManagerSettingsResponse> getManagerSettingsInfo(
      String managerLink, String token) async {
    SettingsLocalData.managerSettingsApiCalled = true;

    ManagerSettingsResponse managerResponse;
    String authorizationToken = 'Bearer $token';

    try {
      final response = await get(
        Uri.parse(managerLink),
        headers: <String, String>{'authorization': authorizationToken},
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        SettingsLocalData.networkConnectionState = true;
        managerResponse = managerSettingsResponseFromJson(response.body);
        return managerResponse;
      } else {
        SettingsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      SettingsLocalData.networkConnectionState = false;
    }
  }
}
