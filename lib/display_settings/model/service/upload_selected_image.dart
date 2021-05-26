import 'package:store_go/display_settings/model/data/display_settings_local_data.dart';
import 'package:store_go/display_settings/model/entities/upload_image_response.dart';
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
              await request.send().timeout(Duration(seconds: 30)));

      if (response.statusCode == 200) {
        DisplaySettingsLocalData.networkConnectionState = true;
        DisplaySettingsLocalData.imageUploadState = true;
        uploadImageResponse = uploadImageResponseFromJson(response.body);
        return uploadImageResponse;
      } else {
        DisplaySettingsLocalData.networkConnectionState = true;
        DisplaySettingsLocalData.imageUploadState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      DisplaySettingsLocalData.networkConnectionState = false;
      DisplaySettingsLocalData.imageUploadState = false;
    }
  }
}
