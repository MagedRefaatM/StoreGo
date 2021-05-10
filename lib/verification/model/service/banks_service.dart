import 'package:store_go/verification/model/entities/banks_info_response.dart';
import 'package:store_go/verification/model/data/verification_local_data.dart';
import 'package:http/http.dart';
import 'dart:async';

class BanksInformationService {
  Future<BanksInformationResponse> getBanksList(
      String banksLink, String applicationId, String applicationSecret) async {
    BanksInformationResponse banksResponse;

    try {
      final response = await get(
        Uri.parse(banksLink),
        headers: <String, String>{
          'X-Application-Id': applicationId,
          'X-Application-Secret': applicationSecret
        },
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        VerificationLocalData.networkConnectionPass = true;
        VerificationLocalData.dataConnectionPass = true;
        banksResponse = banksInformationResponseFromJson(response.body);
        return banksResponse;
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
