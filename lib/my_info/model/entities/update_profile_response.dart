import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) =>
    UpdateProfileResponse.fromJson(json.decode(str));

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.message,
    this.user,
  });

  String message;
  User user;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(
        message: json["message"],
        user: User.fromJson(json["user"]),
      );
}

class User {
  User(
      {this.id,
      this.name,
      this.image,
      this.imageName,
      this.email,
      this.mobile,
      this.token});

  int id;
  String name;
  String image;
  String imageName;
  String token;
  String email;
  String mobile;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      imageName: json["image_name"],
      email: json["email"],
      mobile: json["mobile"],
      token: json["token"]);
}
