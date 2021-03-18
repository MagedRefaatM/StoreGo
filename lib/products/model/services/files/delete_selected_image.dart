import 'package:http/http.dart' as http;
import 'package:store_go/products/model/entities/delete_image_response.dart';

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

    http.Response response =
    await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      deleteResponse = deleteResponseDataFromJson(response.body);
      return deleteResponse;
    } else {
      return null;
    }
  }
}