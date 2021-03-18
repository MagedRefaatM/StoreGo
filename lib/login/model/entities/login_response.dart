import 'dart:convert';

import 'login_response_data.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  LoginResponse({this.data, this.message});

  List<LoginResponseData> data;
  String message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      data: List<LoginResponseData>.from(
          json["data"].map((x) => LoginResponseData.fromJson(x))),
      message: json["message"]);
}
