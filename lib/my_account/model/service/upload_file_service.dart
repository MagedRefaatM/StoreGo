import 'package:store_go/my_account/model/entities/upload_file_response.dart';
import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

class UploadSelectedFile {
  Future<UploadFileResponse> uploadFile(
      String uploadFileLink, File selectedFile) async {
    UploadFileResponse uploadImageResponse;

    var stream = new http.ByteStream(Stream.castFrom(selectedFile.openRead()));
    var length = await selectedFile.length();

    var uri = Uri.parse(uploadFileLink);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(selectedFile.path));

    Map<String, String> requestBody = {
      'file': selectedFile.toString(),
    };

    request.headers['Accept'] = 'application/json';
    request.fields.addAll(requestBody);
    request.files.add(multipartFile);

    try {
      http.Response response = await http.Response.fromStream(
              await request.send().timeout(Duration(seconds: 30)));

      if (response.statusCode == 200) {
        MyAccountLocalData.networkConnectionState = true;
        MyAccountLocalData.dataSuccessState = true;
        uploadImageResponse = uploadFileResponseFromJson(response.body);
        return uploadImageResponse;
      } else {
        MyAccountLocalData.networkConnectionState = true;
        MyAccountLocalData.dataSuccessState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      MyAccountLocalData.networkConnectionState = false;
      MyAccountLocalData.dataSuccessState = false;
    }
  }
}
