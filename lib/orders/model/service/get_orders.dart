import 'package:store_go/orders/model/entities/orders_get_response.dart';
import 'package:store_go/orders/model/data/orders_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class GetOrders {
  Future<OrdersGetResponse> getOrders(
      String ordersLink,
      String token,
      String acceptLanguage,
      String orderLimit,
      String orderPageNumber,
      String orderFilter) async {
    OrdersGetResponse ordersGetResponse;

    String authorizationToken = 'Bearer $token';

    var productsParameters = {
      'limit': orderLimit,
      'page': orderPageNumber,
      'filter': orderFilter,
    };

    String queryString = Uri(queryParameters: productsParameters).query;
    var requestUrl = ordersLink + '?' + queryString;

    try {
      final response = await get(
        Uri.parse(requestUrl),
        headers: <String, String>{
          'authorization': authorizationToken,
          'accept_language': acceptLanguage
        },
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        OrdersLocalData.ordersDataReadyChecker = true;
        OrdersLocalData.networkCallPassedChecker = true;
        OrdersLocalData.ordersNetworkCallChecker = true;
        ordersGetResponse = ordersGetResponseFromJson(response.body);
        return ordersGetResponse;
      } else {
        OrdersLocalData.ordersDataReadyChecker = false;
        OrdersLocalData.networkCallPassedChecker = true;
        OrdersLocalData.ordersNetworkCallChecker = false;
        return null;
      }
    } on TimeoutException catch (_) {
      OrdersLocalData.ordersDataReadyChecker = false;
      OrdersLocalData.ordersNetworkCallChecker = false;
      OrdersLocalData.networkCallPassedChecker = false;
    }
  }
}
