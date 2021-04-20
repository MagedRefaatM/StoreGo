import 'package:store_go/products/model/entities/product_category_response.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class GetProductCategory {
  Future<ProductCategoryResponse> getProductCategory(
      String productCategoryLink, String token) async {
    ProductCategoryResponse getProductCategory;

    String authorizationToken = 'Bearer $token';

    try {
      final response = await get(
        Uri.parse(productCategoryLink),
        headers: <String, String>{'authorization': authorizationToken},
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        ProductsLocalData.networkConnectionState = true;
        getProductCategory = productCategoryResponseFromJson(response.body);
        return getProductCategory;
      } else {
        ProductsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      ProductsLocalData.networkConnectionState = false;
    }
  }
}
