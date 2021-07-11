import 'package:store_go/login/data_layer/data_provider/login_api.dart';

class LoginRepository {
  final LoginApiClient _loginApiClient = LoginApiClient();

  Future<dynamic> getLoginResponse(String email, String password) async {
    final _loginInfo = await _loginApiClient
        .postLoginRequest(email, password);
    if (_loginInfo == null)
      return null;
    if(_loginInfo == 0)
      return 0;

    return _loginInfo.data[0];
  }
}
