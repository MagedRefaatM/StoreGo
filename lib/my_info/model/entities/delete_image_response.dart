import 'dart:convert';

DeleteResponseData deleteResponseDataFromJson(String str) =>
    DeleteResponseData.fromJson(json.decode(str));

class DeleteResponseData {
  DeleteResponseData({
    this.message,
    this.defaultImage,
  });

  String message;
  String defaultImage;

  factory DeleteResponseData.fromJson(Map<String, dynamic> json) =>
      DeleteResponseData(
        message: json["message"],
        defaultImage: json["default_image"],
      );
}
