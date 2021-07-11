import 'package:store_go/verification/data_layer/data_provider/banks_api.dart';

class BanksRepository {
  final _banksApiClient = BanksApiClient();

  Future<dynamic> getLoginResponse() async {
    final _banksList = await _banksApiClient.getAllBanks();
    if (_banksList == null) return null;
    if (_banksList == 0) return 0;

    return _banksList.data;
  }
}
