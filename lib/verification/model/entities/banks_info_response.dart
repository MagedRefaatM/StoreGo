import 'dart:convert';

BanksInformationResponse banksInformationResponseFromJson(String str) =>
    BanksInformationResponse.fromJson(json.decode(str));

String banksInformationResponseToJson(BanksInformationResponse data) =>
    json.encode(data.toJson());

class BanksInformationResponse {
  BanksInformationResponse({
    this.data,
  });

  List<Datum> data;

  factory BanksInformationResponse.fromJson(Map<String, dynamic> json) =>
      BanksInformationResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.code,
    this.sortNumber,
  });

  int id;
  String name;
  String code;
  int sortNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        sortNumber: json["sort_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "sort_number": sortNumber,
      };
}
