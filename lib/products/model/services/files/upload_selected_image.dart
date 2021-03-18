import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:store_go/products/model/entities/upload_image_response.dart';

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

    http.Response response =
    await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      uploadImageResponse = uploadImageResponseFromJson(response.body);
      return uploadImageResponse;
    } else {
      return null;
    }
  }
}