import 'dart:convert';

UploadImageResponse uploadImageResponseFromJson(String str) =>
    UploadImageResponse.fromJson(json.decode(str));

class UploadImageResponse {
  UploadImageResponse({
    this.fileName,
    this.path,
  });

  String fileName;
  String path;

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      UploadImageResponse(
        fileName: json["file_name"],
        path: json["path"],
      );
}
