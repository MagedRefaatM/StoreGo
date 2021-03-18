
import 'dart:convert';

import 'file:///C:/Users/maged.refaat/AndroidStudioProjects/store_go/lib/products/model/entities/product_details_get_response.dart';

ProductUpdateResponse productUpdateResponseFromJson(String str) =>
    ProductUpdateResponse.fromJson(json.decode(str));

class ProductUpdateResponse {
  ProductUpdateResponse({
    this.message,
    this.product,
  });

  String message;
  Data product;

  factory ProductUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ProductUpdateResponse(
        message: json["message"],
        product: Data.fromJson(json["product"]),
      );
}

class OtherImage2 {
  OtherImage2({
    this.id,
    this.name,
    this.path,
  });

  int id;
  String name;
  String path;

  factory OtherImage2.fromJson(Map<String, dynamic> json) => OtherImage2(
    id: json["id"],
    name: json["name"],
    path: json["path"],
  );
}

class StockTransfer2 {
  StockTransfer2({
    this.operationType,
    this.orderId,
    this.source,
    this.quantity,
    this.balance,
    this.operationDate,
  });

  String operationType;
  dynamic orderId;
  String source;
  int quantity;
  dynamic balance;
  String operationDate;

  factory StockTransfer2.fromJson(Map<String, dynamic> json) => StockTransfer2(
    operationType: json["operation_type"],
    orderId: json["order_id"],
    source: json["source"],
    quantity: json["quantity"],
    balance: json["balance"],
    operationDate: json["operation_date"],
  );
}