import 'package:store_go/my_info/model/entities/update_profile_response.dart';
import 'package:store_go/my_info/model/data/my_info_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class GetUpdateProfileResponse {
  Future<UpdateProfileResponse> getUpdateResponse(
      String updateManagerLink,
      String acceptLanguage,
      String token,
      String managerName,
      String managerEmail,
      String managerPassword,
      String managerMobile,
      String managerImageName) async {
    UpdateProfileResponse profileUpdateResponse;

    String authorizationToken = 'Bearer $token';

    Map<String, dynamic> args = {
      'name': managerName,
      'email': managerEmail,
      'password': managerPassword,
      'mobile': managerMobile,
      'image': managerImageName
    };

    try {
      final response = await put(Uri.parse(updateManagerLink),
              headers: <String, String>{
                'authorization': authorizationToken,
                'Accept': 'application/json'
              },
              body: args)
          .timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        MyInfoLocalData.networkConnectionState = true;
        MyInfoLocalData.updateState = true;
        profileUpdateResponse = updateProfileResponseFromJson(response.body);
        return profileUpdateResponse;
      } else {
        MyInfoLocalData.networkConnectionState = true;
        MyInfoLocalData.updateState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      MyInfoLocalData.networkConnectionState = false;
      MyInfoLocalData.updateState = false;
    }
  }
}
