import 'package:store_go/products/model/entities/product_get_response.dart';
import 'package:store_go/store/model/data/store_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class GetProducts {
  Future<ProductsGetRequestData> getProducts(String productsLink, String token,
      String productsLimit, String pageNumber, String productStatus) async {
    ProductsGetRequestData getProductsResponse;

    String authorizationToken = 'Bearer $token';

    var productsParameters = {
      'limit': productsLimit,
      'page': pageNumber,
      'filter': productStatus,
    };

    String queryString = Uri(queryParameters: productsParameters).query;
    var requestUrl = productsLink + '?' + queryString;

    try {
      final response = await get(
        Uri.parse(requestUrl),
        headers: <String, String>{'authorization': authorizationToken},
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        StoreLocalData.networkConnectionState = true;
        StoreLocalData.validDataState = true;
        getProductsResponse = productsGetRequestDataFromJson(response.body);
        return getProductsResponse;
      } else {
        StoreLocalData.networkConnectionState = true;
        StoreLocalData.validDataState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      StoreLocalData.networkConnectionState = false;
      StoreLocalData.validDataState = false;
    }
  }
}
