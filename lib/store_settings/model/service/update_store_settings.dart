import 'package:store_go/store_settings/model/data/store_settings_local_data.dart';
import 'package:store_go/store_settings/model/entities/update_store_response.dart';
import 'package:http/http.dart';
import 'dart:async';

class UpdateStoreSettings {
  Future<ManagerUpdateResponse> getUpdateResponse(
      String updateStoreLink,
      String token,
      int storeEnableState,
      String storeName,
      String storeDescription,
      String storeBillName,
      String storeBillNotes,
      String storeNotificationEmail) async {
    ManagerUpdateResponse updateStoreResponse;

    String authorizationToken = 'Bearer $token';

    Map<String, dynamic> args = {
      'enable_store': storeEnableState.toString(),
      'name': storeName,
      'description': storeDescription,
      'bill_name': storeBillName,
      'bill_notes': storeBillNotes,
      'notification_email': storeNotificationEmail
    };

    try {
      final response = await put(Uri.parse(updateStoreLink),
              headers: <String, String>{
                'authorization': authorizationToken,
              },
              body: args)
          .timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        StoreSettingsLocalData.networkConnectionState = true;
        StoreSettingsLocalData.updateState = true;
        updateStoreResponse = managerUpdateResponseFromJson(response.body);
        return updateStoreResponse;
      } else {
        StoreSettingsLocalData.networkConnectionState = true;
        StoreSettingsLocalData.updateState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      StoreSettingsLocalData.networkConnectionState = false;
      StoreSettingsLocalData.updateState = false;
    }
  }
}
