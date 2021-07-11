import 'dart:convert';

LogoutResponseData logoutResponseDataFromJson(String str) =>
    LogoutResponseData.fromJson(json.decode(str));

class LogoutResponseData {
  LogoutResponseData({
    this.message,
  });

  String message;

  factory LogoutResponseData.fromJson(Map<String, dynamic> json) =>
      LogoutResponseData(
        message: json["message"],
      );
}
