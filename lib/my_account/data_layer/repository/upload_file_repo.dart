import 'package:store_go/my_account/data_layer/data_provider/upload_file_api.dart';
import 'dart:io';

class UploadFileRepository {
  final UploadFileApiClient _fileApiClient = UploadFileApiClient();

  Future<dynamic> getLoginResponse(File selectedFile) async {
    final _uploadResponse =
        await _fileApiClient.uploadSelectedFile(selectedFile);
    if (_uploadResponse == null) return null;
    if (_uploadResponse == 0) return 0;

    return _uploadResponse.data;
  }
}
