import 'package:store_go/settings/model/entities/manager_profile_response.dart';
import 'package:store_go/settings/model/data/settings_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class ManagerProfileService {
  Future<ManagerProfileGetResponse> getManagerProfileInfo(
      String profileLink, String token) async {
    ManagerProfileGetResponse profileResponse;
    String authorizationToken = 'Bearer $token';

    try {
      final response = await get(
        Uri.parse(profileLink),
        headers: <String, String>{'authorization': authorizationToken},
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        SettingsLocalData.networkConnectionState = true;
        profileResponse = managerProfileGetResponseFromJson(response.body);
        return profileResponse;
      } else {
        SettingsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      SettingsLocalData.networkConnectionState = false;
    }
  }
}
