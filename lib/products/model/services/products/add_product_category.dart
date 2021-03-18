import 'package:http/http.dart';
import 'package:store_go/products/model/entities/product_category_response.dart';

class GetProductCategory {
  Future<ProductCategoryResponse> getProductCategory(
      String productCategoryLink, String token) async {
    ProductCategoryResponse getProductCategory;

    String authorizationToken = 'Bearer $token';

    final response = await get(
      Uri.parse(productCategoryLink),
      headers: <String, String>{'authorization': authorizationToken},
    );

    if (response.statusCode == 200) {
      getProductCategory = productCategoryResponseFromJson(response.body);
      return getProductCategory;
    } else {
      return null;
    }
  }
}