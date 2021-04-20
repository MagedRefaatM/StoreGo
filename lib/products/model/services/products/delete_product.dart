import 'package:store_go/products/model/entities/product_delete_response.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class DeleteProduct {
  Future<ProductDeleteResponse> deleteProduct(
      String productDeleteLink, String token, String productId) async {
    ProductDeleteResponse getProductDeleteResponse;

    String authorizationToken = 'Bearer $token';

    var productsParameters = {
      'id': productId,
    };

    String queryString = Uri(queryParameters: productsParameters).query;
    var requestUrl = productDeleteLink + '?' + queryString;

    try {
      final response = await delete(
        Uri.parse(requestUrl),
        headers: <String, String>{'authorization': authorizationToken},
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        ProductsLocalData.networkConnectionState = true;
        getProductDeleteResponse = productDeleteResponseFromJson(response.body);
        return getProductDeleteResponse;
      } else {
        ProductsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      ProductsLocalData.networkConnectionState = false;
    }
  }
}
