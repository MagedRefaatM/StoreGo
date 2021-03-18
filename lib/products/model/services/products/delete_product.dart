import 'package:http/http.dart';
import 'package:store_go/products/model/entities/product_delete_response.dart';

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

    final response = await delete(
      Uri.parse(requestUrl),
      headers: <String, String>{'authorization': authorizationToken},
    );

    if (response.statusCode == 200) {
      getProductDeleteResponse = productDeleteResponseFromJson(response.body);
      return getProductDeleteResponse;
    } else {
      return null;
    }
  }
}