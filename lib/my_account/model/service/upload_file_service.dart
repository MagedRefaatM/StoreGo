import 'package:store_go/my_account/model/entities/upload_file_response.dart';
import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class UploadFileService {
  Future<UploadFileResponse> uploadFile(
      String uploadFileLink, String filePath) async {
    UploadFileResponse uploadResponse;

    try {
      final response = await post(
        Uri.parse(uploadFileLink),
        headers: <String, String>{'Accept': 'application/json'},
        body: <String, dynamic>{'file': filePath},
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        MyAccountLocalData.networkConnectionState = true;
        MyAccountLocalData.dataSuccessState = true;
        uploadResponse = uploadFileResponseFromJson(response.body);
        return uploadResponse;
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
