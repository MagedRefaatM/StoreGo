class LoginResponseData {
  LoginResponseData(
      {this.id,
      this.name,
      this.image,
      this.token,
      this.sureBillAppId,
      this.sureBillAppSecret});

  int id;
  String name;
  String image;
  String token;
  String sureBillAppId;
  String sureBillAppSecret;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      LoginResponseData(
          id: json["id"],
          name: json["name"],
          image: json["image"],
          token: json["token"],
          sureBillAppId: json["surebills_application_id"],
          sureBillAppSecret: json["surebills_application_secret"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "token": token,
        "surebills_application_id": sureBillAppId,
        "surebills_application_secret": sureBillAppSecret
      };
}
