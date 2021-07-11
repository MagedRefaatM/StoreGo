import 'package:store_go/verification/data_layer/data_model/banks_info_response.dart';
import 'package:store_go/login/data_layer/data_model/login_response.dart';
import 'package:store_go/login/shared_pref/shared_pref.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class BanksApiClient {
  final _banksEndpoint = 'https://sandbox-bills.surepay.sa/api/v1/banks';
  final _sharedPref = SharedPref();

  Future<dynamic> getAllBanks() async {
    try {
      final _result = LoginData.fromJson(await _sharedPref.read("loginInfo"));

      final _callResponse = await get(
        Uri.parse(_banksEndpoint),
        headers: <String, String>{
          'X-Application-Id': _result.surebillsApplicationId,
          'X-Application-Secret': _result.surebillsApplicationSecret
        },
      ).timeout(Duration(seconds: 5));

      if (_callResponse.statusCode != 200) return null;

      return BanksInformationResponse.fromJson(jsonDecode(_callResponse.body));
    } on TimeoutException catch (_) {
      return 0;
    }
  }
}
