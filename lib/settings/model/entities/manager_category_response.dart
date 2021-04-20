import 'dart:convert';

ManagerProductCategory managerProductCategoryFromJson(String str) =>
    ManagerProductCategory.fromJson(json.decode(str));

String managerProductCategoryToJson(ManagerProductCategory data) =>
    json.encode(data.toJson());

class ManagerProductCategory {
  ManagerProductCategory({
    this.data,
  });

  List<Datum> data;

  factory ManagerProductCategory.fromJson(Map<String, dynamic> json) =>
      ManagerProductCategory(
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
    this.order,
    this.deleted,
  });

  int id;
  String name;
  int order;
  bool deleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        order: json["order"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "order": order, "deleted": deleted};
}
