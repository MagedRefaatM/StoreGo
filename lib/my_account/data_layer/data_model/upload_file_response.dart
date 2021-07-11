import 'dart:convert';

UploadFileResponse uploadFileResponseFromJson(String str) =>
    UploadFileResponse.fromJson(json.decode(str));

String uploadFileResponseToJson(UploadFileResponse data) =>
    json.encode(data.toJson());

class UploadFileResponse {
  UploadFileResponse({
    this.data,
  });

  String data;

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) =>
      UploadFileResponse(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
