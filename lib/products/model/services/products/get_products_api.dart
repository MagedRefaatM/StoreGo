import 'package:http/http.dart';
import 'package:store_go/products/model/entities/product_get_response.dart';

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

    final response = await get(
      Uri.parse(requestUrl),
      headers: <String, String>{'authorization': authorizationToken},
    );

    if (response.statusCode == 200) {
      getProductsResponse = productsGetRequestDataFromJson(response.body);
      return getProductsResponse;
    } else {
      return null;
    }
  }
}
