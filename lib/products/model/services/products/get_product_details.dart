import 'package:http/http.dart';
import 'package:store_go/products/model/entities/product_details_get_response.dart';

class GetProductDetails {
  Future<ProductDetailsResponse> getProductDetails(
      String productDetailsLink, String productId, String token) async {
    ProductDetailsResponse getProductDetails;

    String authorizationToken = 'Bearer $token';

    String detailsLink = '$productDetailsLink$productId';

    final response = await get(
      Uri.parse(detailsLink),
      headers: <String, String>{'authorization': authorizationToken},
    );

    if (response.statusCode == 200) {
      getProductDetails = productDetailsResponseFromJson(response.body);
      return getProductDetails;
    } else {
      return null;
    }
  }
}