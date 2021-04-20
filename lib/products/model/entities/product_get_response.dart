import 'package:store_go/products/model/entities/single_product.dart';
import 'dart:convert';

ProductsGetRequestData productsGetRequestDataFromJson(String str) =>
    ProductsGetRequestData.fromJson(json.decode(str));

class ProductsGetRequestData {
  ProductsGetRequestData(
      {this.data,
      this.totalProducts,
      this.totalPages,
      this.totalActive,
      this.totalEmpty,
      this.totalNotActive});

  List<SingleProduct> data;
  int totalActive;
  int totalNotActive;
  int totalEmpty;
  int totalProducts;
  int totalPages;

  factory ProductsGetRequestData.fromJson(Map<String, dynamic> json) =>
      ProductsGetRequestData(
          data: List<SingleProduct>.from(
              json["data"].map((x) => SingleProduct.fromJson(x))),
          totalProducts: json["total_products"],
          totalPages: json["total_pages"],
          totalActive: json["total_active"],
          totalEmpty: json["total_empty"],
          totalNotActive: json["total_not_active"]);
}
