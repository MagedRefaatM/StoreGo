import 'dart:convert';

ProductDeleteResponse productDeleteResponseFromJson(String str) =>
    ProductDeleteResponse.fromJson(json.decode(str));

class ProductDeleteResponse {
  ProductDeleteResponse({
    this.message,
  });

  String message;

  factory ProductDeleteResponse.fromJson(Map<String, dynamic> json) =>
      ProductDeleteResponse(
        message: json["message"],
      );
}