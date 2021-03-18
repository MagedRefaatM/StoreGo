import 'dart:convert';

ProductDetailsResponse productDetailsResponseFromJson(String str) =>
    ProductDetailsResponse.fromJson(json.decode(str));

class ProductDetailsResponse {
  ProductDetailsResponse({
    this.data,
  });

  Data data;

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.id,
    this.name,
    this.image,
    this.mainImageName,
    this.price,
    this.status,
    this.quantity,
    this.createdAt,
    this.slugKey,
    this.categoryId,
    this.otherImages,
    this.otherImagesNames,
    this.description,
    this.stockTransfer,
    this.imageStatus,
  });

  int id;
  String name;
  String image;
  String mainImageName;
  String price;
  dynamic status;
  dynamic quantity;
  String createdAt;
  String slugKey;
  dynamic categoryId;
  List<OtherImage> otherImages;
  List<String> otherImagesNames;
  String description;
  List<StockTransfer> stockTransfer;
  bool imageStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    mainImageName: json["main_image_name"],
    price: json["price"],
    status: json["status"],
    quantity: json["quantity"],
    createdAt: json["created_at"],
    slugKey: json["slug_key"],
    categoryId: json["category_id"],
    otherImages: List<OtherImage>.from(
        json["other_images"].map((x) => OtherImage.fromJson(x))),
    otherImagesNames:
    List<String>.from(json["other_images_names"].map((x) => x)),
    description: json["description"],
    stockTransfer: List<StockTransfer>.from(
        json["stock_transfer"].map((x) => StockTransfer.fromJson(x))),
    imageStatus: json["image_status"],
  );
}

class OtherImage {
  OtherImage({
    this.id,
    this.name,
    this.path,
  });

  int id;
  String name;
  String path;

  factory OtherImage.fromJson(Map<String, dynamic> json) => OtherImage(
    id: json["id"],
    name: json["name"],
    path: json["path"],
  );
}

class StockTransfer {
  StockTransfer({
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

  factory StockTransfer.fromJson(Map<String, dynamic> json) => StockTransfer(
    operationType: json["operation_type"],
    orderId: json["order_id"],
    source: json["source"],
    quantity: json["quantity"],
    balance: json["balance"],
    operationDate: json["operation_date"],
  );
}