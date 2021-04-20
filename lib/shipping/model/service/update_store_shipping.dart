import 'package:store_go/settings/model/entities/manager_settings_response.dart';
import 'package:store_go/shipping/model/entities/update_store_shipping.dart';
import 'package:store_go/shipping/model/data/shipping_local_data.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class UpdateStoreShipping {
  Future<ManagerUpdateResponse> getUpdateResponse(
      String updateStoreLink,
      String token,
      int shippingEnableState,
      List<ShippingPriceList> shippingAreasList) async {
    ManagerUpdateResponse updateStoreResponse;

    String authorizationToken = 'Bearer $token';

    try {
      final response = await put(
        Uri.parse(updateStoreLink),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': authorizationToken,
        },
        body: jsonEncode(<String, dynamic>{
          'enable_shipping_price_list': shippingEnableState.toString(),
          'shipping_price_list': shippingAreasList,
        }),
      ).timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        ShippingLocalData.networkConnectionState = true;
        ShippingLocalData.updateState = true;
        updateStoreResponse = managerUpdateResponseFromJson(response.body);
        return updateStoreResponse;
      } else {
        ShippingLocalData.networkConnectionState = true;
        ShippingLocalData.updateState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      ShippingLocalData.networkConnectionState = false;
      ShippingLocalData.updateState = false;
    }
  }
}
