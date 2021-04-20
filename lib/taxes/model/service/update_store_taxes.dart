import 'package:store_go/taxes/model/entities/update_store_taxes.dart';
import 'package:store_go/taxes/model/data/taxes_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class UpdateStoreTaxes {
  Future<ManagerUpdateResponse> getUpdateResponse(
      String updateStoreLink,
      String token,
      int taxEnableState,
      String taxFare,
      String taxNumber) async {
    ManagerUpdateResponse updateStoreResponse;

    String authorizationToken = 'Bearer $token';

    Map<String, dynamic> args = {
      'enable_tax': taxEnableState.toString(),
      'tax_value': taxFare,
      'tax_number': taxNumber
    };

    try {
      final response = await put(Uri.parse(updateStoreLink),
              headers: <String, String>{
                'authorization': authorizationToken,
              },
              body: args)
          .timeout(Duration(seconds: 8));

      if (response.statusCode == 200) {
        TaxesLocalData.networkConnectionState = true;
        TaxesLocalData.updateState = true;
        updateStoreResponse = managerUpdateResponseFromJson(response.body);
        return updateStoreResponse;
      } else {
        TaxesLocalData.networkConnectionState = true;
        TaxesLocalData.updateState = false;
        return null;
      }
    } on TimeoutException catch (_) {
      TaxesLocalData.networkConnectionState = false;
      TaxesLocalData.updateState = false;
    }
  }
}
