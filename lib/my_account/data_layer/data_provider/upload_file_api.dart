import 'package:store_go/my_account/data_layer/data_model/upload_file_response.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class UploadFileApiClient {
  final _uploadFileEndpoint = 'https://sandbox-bills.surepay.sa/api/upload';

  Future<dynamic> uploadSelectedFile(File selectedFile) async {
    try {
      var stream =
          new http.ByteStream(Stream.castFrom(selectedFile.openRead()));
      var length = await selectedFile.length();

      var uri = Uri.parse(_uploadFileEndpoint);

      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(selectedFile.path));

      Map<String, String> requestBody = {
        'file': selectedFile.toString(),
      };

      request.headers['Accept'] = 'application/json';
      request.fields.addAll(requestBody);
      request.files.add(multipartFile);

      http.Response response = await http.Response.fromStream(
          await request.send().timeout(Duration(seconds: 30)));

      if (response.statusCode != 200) return null;

      return UploadFileResponse.fromJson(jsonDecode(response.body));
    } on TimeoutException catch (_) {
      return 0;
    }
  }
}
