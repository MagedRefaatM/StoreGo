import 'package:store_go/verification/data_layer/data_provider/logout_api.dart';

class LogoutRepository {
  final _logoutApiClient = LogoutApiClient();

  Future<dynamic> getLogoutResponse() async {
    final _logoutInfo = await _logoutApiClient.postLogoutRequest();
    if (_logoutInfo == null) return null;
    if (_logoutInfo == 0) return 0;

    return _logoutInfo.message;
  }
}
