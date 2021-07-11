import 'package:equatable/equatable.dart';
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse extends Equatable {
  LoginResponse({
    this.data,
  });

  final List<LoginData> data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        data: List<LoginData>.from(json["data"].map((x) => LoginData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object> get props => [this.data];
}

class LoginData extends Equatable {
  LoginData({
    this.id,
    this.name,
    this.image,
    this.imageName,
    this.email,
    this.imageStatus,
    this.mobile,
    this.token,
    this.surebillsApplicationId,
    this.surebillsApplicationSecret,
  });

  final int id;
  final String name;
  final String image;
  final dynamic imageName;
  final String email;
  final int imageStatus;
  final String mobile;
  final String token;
  final String surebillsApplicationId;
  final String surebillsApplicationSecret;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        imageName: json["image_name"],
        email: json["email"],
        imageStatus: json["image_status"],
        mobile: json["mobile"],
        token: json["token"],
        surebillsApplicationId: json["surebills_application_id"],
        surebillsApplicationSecret: json["surebills_application_secret"],
      );

  @override
  List<Object> get props => [
        this.id,
        this.name,
        this.image,
        this.imageName,
        this.email,
        this.imageStatus,
        this.mobile,
        this.token,
        this.surebillsApplicationId,
        this.surebillsApplicationSecret
      ];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "image_name": imageName,
        "email": email,
        "image_status": imageStatus,
        "mobile": mobile,
        "token": token,
        "surebills_application_id": surebillsApplicationId,
        "surebills_application_secret": surebillsApplicationSecret,
      };
}
