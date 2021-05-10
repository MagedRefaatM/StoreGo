import 'package:store_go/my_info/model/entities/upload_image_response.dart';
import 'package:store_go/my_info/model/data/my_info_local_data.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

class UploadSelectedImage {
  Future<UploadImageResponse> uploadImage(
      String uploadFileLink,
      String userToken,
      File selectedFile,
      String path,
      String selectedType) async {
    UploadImageResponse uploadImageResponse;

    String authorizationToken = 'Bearer $userToken';

    var stream = new http.ByteStream(Stream.castFrom(selectedFile.openRead()));
    var length = await selectedFile.length();

    var uri = Uri.parse(uploadFileLink);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(selectedFile.path));

    Map<String, String> requestBody = {
      'type': 'image',
      'file': selectedFile.toString(),
    };

    request.headers['Authorization'] = authorizationToken;
    request.fields.addAll(requestBody);
    request.files.add(multipartFile);

    try {
      http.Response response = await http.Response.fromStream(
              await request.send().timeout(Duration(seconds: 10)))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        MyInfoLocalData.networkConnectionState = true;
        MyInfoLocalData.imageUploadedState = true;
        uploadImageResponse = uploadImageResponseFromJson(response.body);
        return uploadImageResponse;
      } else {
        MyInfoLocalData.networkConnectionState = true;
        MyInfoLocalData.imageUploadedState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      MyInfoLocalData.networkConnectionState = false;
      MyInfoLocalData.imageUploadedState = false;
    }
  }
}
