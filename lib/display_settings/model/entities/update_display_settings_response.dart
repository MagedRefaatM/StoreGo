import 'dart:convert';

ManagerUpdateResponse managerUpdateResponseFromJson(String str) =>
    ManagerUpdateResponse.fromJson(json.decode(str));

class ManagerUpdateResponse {
  ManagerUpdateResponse({
    this.message,
  });

  String message;

  factory ManagerUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ManagerUpdateResponse(
        message: json["message"],
      );
}
