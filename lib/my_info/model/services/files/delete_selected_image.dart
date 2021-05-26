import 'package:store_go/my_info/model/entities/delete_image_response.dart';
import 'package:store_go/my_info/model/data/my_info_local_data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class DeleteSelectedImage {
  Future<DeleteResponseData> getDeleteResponse(String deleteFileLink,
      String acceptLanguage, String fileName, String userToken) async {
    DeleteResponseData deleteResponse;

    String authorizationToken = 'Bearer $userToken';

    http.Request request = http.Request('DELETE', Uri.parse(deleteFileLink))
      ..headers.addAll({
        'authorization': authorizationToken,
        'accept_language': acceptLanguage,
      });

    request.bodyFields = {
      'file_name': fileName,
    };

    try {
      http.Response response = await http.Response.fromStream(
              await request.send().timeout(Duration(seconds: 30)));

      if (response.statusCode == 200) {
        MyInfoLocalData.networkConnectionState = true;
        MyInfoLocalData.imageDeleteState = true;
        deleteResponse = deleteResponseDataFromJson(response.body);
        return deleteResponse;
      } else {
        MyInfoLocalData.networkConnectionState = true;
        MyInfoLocalData.imageDeleteState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      MyInfoLocalData.networkConnectionState = false;
      MyInfoLocalData.imageDeleteState = false;
    }
  }
}
