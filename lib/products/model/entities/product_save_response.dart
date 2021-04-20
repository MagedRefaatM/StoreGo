import 'dart:convert';

ProductSaveResponse productSaveResponseFromJson(String str) =>
    ProductSaveResponse.fromJson(json.decode(str));

class ProductSaveResponse {
  ProductSaveResponse({
    this.message,
    this.product,
  });

  String message;
  Product product;

  factory ProductSaveResponse.fromJson(Map<String, dynamic> json) =>
      ProductSaveResponse(
        message: json["message"],
        product: Product.fromJson(json["product"]),
      );
}

class Product {
  Product({
    this.id,
    this.name,
    this.image,
    this.price,
    this.status,
    this.quantity,
    this.createdAt,
    this.slugKey,
  });

  int id;
  String name;
  String image;
  String price;
  int status;
  String quantity;
  String createdAt;
  String slugKey;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        status: int.parse(json["status"].toString()),
        quantity: json["quantity"],
        createdAt: json["created_at"],
        slugKey: json["slug_key"],
      );
}
