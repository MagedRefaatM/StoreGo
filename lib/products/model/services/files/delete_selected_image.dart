import 'package:store_go/products/model/entities/delete_image_response.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
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
              await request.send().timeout(Duration(seconds: 5)))
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        ProductsLocalData.networkConnectionState = true;
        ProductsLocalData.imageDeleteState = true;
        deleteResponse = deleteResponseDataFromJson(response.body);
        return deleteResponse;
      } else {
        ProductsLocalData.networkConnectionState = true;
        ProductsLocalData.imageDeleteState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      ProductsLocalData.networkConnectionState = false;
      ProductsLocalData.imageDeleteState = false;
    }
  }
}
