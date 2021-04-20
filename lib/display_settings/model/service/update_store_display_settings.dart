import 'package:store_go/display_settings/model/entities/update_display_settings_response.dart';
import 'package:store_go/display_settings/model/data/display_settings_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class UpdateDisplaySettings {
  Future<ManagerUpdateResponse> getUpdateResponse(
      String updateStoreLink,
      String token,
      String logoImageName,
      String bannerImageName,
      String bottomImageName,
      String browserImageName,
      String facebookLink,
      String instagramLink,
      String snapchatLink,
      String tiktokLink,
      String twitterLink,
      String youtubeLink,
      String whatsappNumber) async {
    ManagerUpdateResponse updateStoreResponse;

    String authorizationToken = 'Bearer $token';

    Map<String, dynamic> args = {
      'logo': logoImageName,
      'banner': bannerImageName,
      'favicon': browserImageName,
      'footer_logo': bottomImageName,
      'facebook_url': facebookLink,
      'twitter_url': twitterLink,
      'instagram_url': instagramLink,
      'youtube_url': youtubeLink,
      'snapchat_url': snapchatLink,
      'tiktok_url': tiktokLink,
      'whatsapp_number': whatsappNumber
    };

    print(args);

    try {
      final response = await put(Uri.parse(updateStoreLink),
              headers: <String, String>{
                'authorization': authorizationToken,
              },
              body: args)
          .timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        DisplaySettingsLocalData.networkConnectionState = true;
        DisplaySettingsLocalData.updateState = true;
        updateStoreResponse = managerUpdateResponseFromJson(response.body);
        return updateStoreResponse;
      } else {
        DisplaySettingsLocalData.networkConnectionState = true;
        DisplaySettingsLocalData.updateState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      DisplaySettingsLocalData.networkConnectionState = false;
      DisplaySettingsLocalData.updateState = false;
    }
  }
}
