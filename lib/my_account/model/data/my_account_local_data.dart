import 'package:store_go/verification/model/entities/account_info_response.dart';
import 'package:store_go/verification/model/entities/banks_info_response.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class MyAccountLocalData {
  String userLoggedInApplicationSecret;
  String userLoggedInApplicationId;
  String accountInfoUpdateLink =
      'https://sandbox-bills.surepay.sa/api/v1/account/information';
  String uploadFileLink = 'https://sandbox-bills.surepay.sa/api/upload';

  static Data accountInformation;
  static List<Datum> banksList;

  static bool networkConnectionState;
  static bool dataSuccessState;

  static String sureBiiDomain = 'https://sandbox-bills.surepay.sa/';
  static String stateMessage;

  MyAccountLocalData() {
    userLoggedInApplicationSecret = LoginLocalData.sureBillAppSecret;
    userLoggedInApplicationId = LoginLocalData.sureBillAppId;
  }
}
