import 'package:store_go/verification/model/entities/account_info_response.dart';
import 'package:store_go/verification/model/entities/banks_info_response.dart';
import 'package:store_go/login/model/data/login_local_data.dart';

class MyAccountLocalData {
  String accountInfoUpdateLink =
      'https://sandbox-bills.surepay.sa/api/v1/account/information';
  String userLoggedInApplicationSecret;
  String userLoggedInApplicationId;

  static Data accountInformation;
  static List<Datum> banksList;

  static int commercialDocumentIndex = 1;
  static int bankDocumentIndex = 1;

  static bool networkConnectionState;

  static String stateMessage;

  MyAccountLocalData() {
    userLoggedInApplicationSecret = LoginLocalData.sureBillAppSecret;
    userLoggedInApplicationId = LoginLocalData.sureBillAppId;
  }
}
