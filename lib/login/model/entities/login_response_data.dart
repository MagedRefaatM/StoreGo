class LoginResponseData {
  LoginResponseData({
    this.id,
    this.name,
    this.image,
    this.token,
  });

  int id;
  String name;
  String image;
  String token;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      LoginResponseData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "token": token,
  };
}