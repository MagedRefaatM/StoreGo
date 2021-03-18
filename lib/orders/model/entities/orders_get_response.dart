import 'dart:convert';

OrdersGetResponse ordersGetResponseFromJson(String str) =>
    OrdersGetResponse.fromJson(json.decode(str));

class OrdersGetResponse {
  OrdersGetResponse({
    this.data,
    this.totalOrders,
    this.totalPages,
    this.totalNew,
    this.totalReady,
    this.totalShipped,
  });

  List<SingleOrder> data;
  int totalOrders;
  int totalPages;
  int totalNew;
  int totalReady;
  int totalShipped;

  factory OrdersGetResponse.fromJson(Map<String, dynamic> json) =>
      OrdersGetResponse(
        data: List<SingleOrder>.from(json["data"].map((x) => SingleOrder.fromJson(x))),
        totalOrders: json["total_orders"],
        totalPages: json["total_pages"],
        totalNew: json["total_new"],
        totalReady: json["total_ready"],
        totalShipped: json["total_shipped"],
      );
}

class SingleOrder {
  SingleOrder({
    this.id,
    this.number,
    this.createdAt,
    this.status,
    this.finalTotal,
    this.customerName,
    this.numOfProducts,
    this.orderSource,
    this.enableUpdateCart,
  });

  int id;
  String number;
  String createdAt;
  String status;
  String finalTotal;
  String customerName;
  int numOfProducts;
  String orderSource;
  String enableUpdateCart;

  factory SingleOrder.fromJson(Map<String, dynamic> json) => SingleOrder(
        id: json["id"],
        number: json["number"],
        createdAt: json["created_at"],
        status: json["status"],
        finalTotal: json["final_total"],
        customerName: json["customer_name"],
        numOfProducts: json["num_of_products"],
        orderSource: json["order_source"],
        enableUpdateCart: json["enable_update_cart"],
      );
}
