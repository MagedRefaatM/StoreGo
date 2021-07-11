import 'package:store_go/verification/data_layer/data_provider/account_info_api.dart';

class AccountInformationRepository {
  final _accountInfoApiClient = AccountInfoApiClient();

  Future<dynamic> getAccountInfo() async {
    final _accountInfo = await _accountInfoApiClient.getAccountInfo();
    if (_accountInfo == null) return null;
    if (_accountInfo == 0) return 0;

    return _accountInfo.data;
  }
}
