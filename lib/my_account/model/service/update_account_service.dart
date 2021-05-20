import 'package:store_go/verification/model/entities/account_info_response.dart';
import 'package:store_go/my_account/model/entities/update_account_response.dart';
import 'package:store_go/my_account/model/data/my_account_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class UpdateAccountService {
  Future<UpdateAccountResponse> updateAccountInformation(
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
    UpdateAccountResponse updateResponse;

    try {
      final response = await post(
        Uri.parse(updateAccountLink),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: <String, dynamic>{
          'application-id': applicationId,
          'application-secret': applicationSecret,
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
        },
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        print('Success');
        MyAccountLocalData.networkConnectionState = true;
        updateResponse = updateAccountResponseFromJson(response.body);
        return updateResponse;
      } else {
        print('Error with sCode: ${response.statusCode} and body: ${response.body}');
        MyAccountLocalData.networkConnectionState = true;
        return null;
      }
    } on TimeoutException catch (_) {
      MyAccountLocalData.networkConnectionState = false;
    }
  }
}