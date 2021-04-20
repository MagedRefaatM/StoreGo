import 'package:store_go/products/model/entities/product_save_response.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class GetSaveProductResponse {
  Future<ProductSaveResponse> getSaveResponse(
      String savePostLink,
      String token,
      String productName,
      String productCategoryId,
      String productPrice,
      String productDescription,
      String productQuantityState,
      String productQuantity,
      String productStatus,
      String productImage,
      List<String> productOtherImages) async {
    ProductSaveResponse productSaveResponse;

    String authorizationToken = 'Bearer $token';

    Map<String, dynamic> args = {
      'name': productName,
      'price': productPrice,
      'description': productDescription,
      'quantity_status': productQuantityState,
      'quantity': productQuantity,
      'status': productStatus,
      'image': productImage,
      "images": productOtherImages.toString()
    };

    try {
      final response = await post(Uri.parse(savePostLink),
              headers: <String, String>{
                'authorization': authorizationToken,
                'Accept': 'application/json',
              },
              body: args)
          .timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        ProductsLocalData.networkConnectionState = true;
        productSaveResponse = productSaveResponseFromJson(response.body);
        return productSaveResponse;
      } else {
        ProductsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      ProductsLocalData.networkConnectionState = false;
    }
  }
}
