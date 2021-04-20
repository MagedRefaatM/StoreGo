import 'package:store_go/products/model/entities/product_details_get_response.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class GetProductDetails {
  Future<ProductDetailsResponse> getProductDetails(
      String productDetailsLink, String productId, String token) async {
    ProductDetailsResponse getProductDetails;

    String authorizationToken = 'Bearer $token';

    String detailsLink = '$productDetailsLink$productId';

    try {
      final response = await get(
        Uri.parse(detailsLink),
        headers: <String, String>{'authorization': authorizationToken},
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        ProductsLocalData.networkConnectionState = true;
        getProductDetails = productDetailsResponseFromJson(response.body);
        return getProductDetails;
      } else {
        ProductsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      ProductsLocalData.networkConnectionState = false;
    }
  }
}
