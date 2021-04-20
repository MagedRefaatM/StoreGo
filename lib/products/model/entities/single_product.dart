import 'package:flutter/material.dart';

class SingleProduct {
  int id;
  int status;
  dynamic quantity;

  String name;
  String imageLink;
  dynamic price;
  String createdAt;

  Color statusColor;
  Color amountColor;

  SingleProduct({
    this.id,
    this.status,
    this.quantity,
    this.createdAt,
    this.name,
    this.imageLink,
    this.price,
  });

  factory SingleProduct.fromJson(Map<String, dynamic> json) => SingleProduct(
        id: json["id"],
        name: json["name"],
        imageLink: json["image"],
        price: json["price"],
        status: json["status"],
        quantity: json["quantity"],
        createdAt: json["created_at"],
      );
}
