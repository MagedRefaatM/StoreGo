import 'dart:convert';

ProductCategoryResponse productCategoryResponseFromJson(String str) =>
    ProductCategoryResponse.fromJson(json.decode(str));

class ProductCategoryResponse {
  ProductCategoryResponse({
    this.data,
  });

  List<SingleCategory> data;

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ProductCategoryResponse(
        data: List<SingleCategory>.from(
            json["data"].map((x) => SingleCategory.fromJson(x))),
      );
}

class SingleCategory {
  SingleCategory({
    this.id,
    this.name,
    this.order,
  });

  int id;
  String name;
  int order;

  factory SingleCategory.fromJson(Map<String, dynamic> json) => SingleCategory(
        id: json["id"],
        name: json["name"],
        order: json["order"],
      );
}
