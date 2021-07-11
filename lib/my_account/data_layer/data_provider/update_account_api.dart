import 'package:store_go/my_account/data_layer/data_model/update_account_response.dart';
import 'package:store_go/verification/data_layer/data_model/account_info_response.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class UpdateAccountApiClient {
  final _updateAccountEndpoint =
      'https://sandbox-bills.surepay.sa/api/v1/account/information';

  Future<dynamic> postUpdateRequest(
      String updateAccountLink,
      String applicationId,
      String applicationSecret,
      String type,
      String ibanNumber,
      String beneficiaryName,
      String licenseType,
      String expireDate,
      String englishName,
      String arabicName,
      String address,
      int mobileNumber,
      int bankId,
      List<Document> businessDocuments,
      List<Document> bankDocuments) async {
    try {
      final _callResponse = await post(
        Uri.parse(_updateAccountEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'application_id': applicationId,
          'application_secret': applicationSecret,
          'type': type,
          'iban_number': ibanNumber,
          'beneficiary_name': beneficiaryName,
          'license_type': licenseType,
          'commercial_registry_expiry_date': expireDate,
          'business_name_en': englishName,
          'business_name_ar': arabicName,
          'business_address': address,
          'business_mobile': mobileNumber.toString(),
          'bank_id': bankId.toString(),
          'business_documents': businessDocuments,
          'bank_documents': bankDocuments
        }),
      ).timeout(Duration(seconds: 10));

      if (_callResponse.statusCode != 200) return null;

      return UpdateAccountResponse.fromJson(jsonDecode(_callResponse.body));
    } on TimeoutException catch (_) {
      return 0;
    }
  }
}
