import 'package:store_go/products/model/entities/product_update_response.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class GetUpdateProductResponse {
  Future<ProductUpdateResponse> getUpdateResponse(
      String updatePostLink,
      String token,
      String productId,
      String productName,
      String productCategoryId,
      String productPrice,
      String productDescription,
      String productQuantityState,
      String productQuantity,
      String productStatus,
      String productImage,
      List<String> productOtherImages,
      List<String> productOtherDeletedImages) async {
    ProductUpdateResponse productUpdateResponse;

    String authorizationToken = 'Bearer $token';

    Map<String, dynamic> args = {
      'id': productId,
      'name': productName,
      'price': productPrice,
      'description': productDescription,
      'quantity_status': productQuantityState,
      'quantity': productQuantity,
      'status': productStatus,
      'image': productImage,
      "images": productOtherImages.toString(),
      "deleted_files": productOtherDeletedImages.join(',').toString()
    };

    try {
      final response = await put(Uri.parse(updatePostLink),
              headers: <String, String>{
                'authorization': authorizationToken,
                'Accept': 'application/json'
              },
              body: args)
          .timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        ProductsLocalData.networkConnectionState = true;
        productUpdateResponse = productUpdateResponseFromJson(response.body);
        return productUpdateResponse;
      } else {
        ProductsLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      ProductsLocalData.networkConnectionState = false;
    }
  }
}
