import 'dart:convert';

ManagerProfileGetResponse managerProfileGetResponseFromJson(String str) =>
    ManagerProfileGetResponse.fromJson(json.decode(str));

class ManagerProfileGetResponse {
  ManagerProfileGetResponse({
    this.data,
  });

  Data data;

  factory ManagerProfileGetResponse.fromJson(Map<String, dynamic> json) =>
      ManagerProfileGetResponse(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.id,
    this.name,
    this.image,
    this.imageName,
    this.email,
    this.imageStatus,
    this.mobile,
  });

  int id;
  int imageStatus;
  String name;
  String image;
  String imageName;
  String email;
  String mobile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        imageName: json["image_name"],
        email: json["email"],
        imageStatus: json["image_status"],
        mobile: json["mobile"],
      );
}
