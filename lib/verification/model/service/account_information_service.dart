import 'package:store_go/verification/model/entities/account_info_response.dart';
import 'package:store_go/verification/model/data/verification_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class AccountInformationService {
  Future<AccountInformationResponse> getAccountInformation(
      String accountInfoLink,
      String applicationId,
      String applicationSecret) async {
    AccountInformationResponse informationResponse;

    try {
      final response = await get(
        Uri.parse(accountInfoLink),
        headers: <String, String>{
          'X-Application-Id': applicationId,
          'X-Application-Secret': applicationSecret
        },
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        VerificationLocalData.networkConnectionPass = true;
        VerificationLocalData.dataConnectionPass = true;
        informationResponse = accountInformationResponseFromJson(response.body);
        return informationResponse;
      } else {
        VerificationLocalData.networkConnectionPass = true;
        VerificationLocalData.dataConnectionPass = false;
        return null;
      }
    } on TimeoutException catch (_) {
      VerificationLocalData.networkConnectionPass = false;
      VerificationLocalData.dataConnectionPass = false;
    }
  }
}
