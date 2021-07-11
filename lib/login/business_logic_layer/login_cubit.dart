import 'package:store_go/login/data_layer/repository/login_repo.dart';
import 'package:store_go/login/shared_pref/shared_pref.dart';
import 'package:bloc/bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _loginRepository = LoginRepository();
  final _sharedPref = SharedPref();

  LoginCubit() : super(LoginInitial());
  void login(String storeEmail, String storePassword) {
    var message = validateInputs(storeEmail, storePassword);
    if (message.isNotEmpty)
      emit(InvalidInputs(errorMessage: message));
    else {
      emit(Loading());

      _loginRepository
          .getLoginResponse(storeEmail, storePassword)
          .then((loginResponse) {
        if (loginResponse != null) {
          _sharedPref.save("loginInfo", loginResponse);
          emit(LoginSuccess(loginResponse));
        } else if (loginResponse == 0)
          emit(ConnectionTimeout(
              timeoutMessage: 'برجاء التحقق من إتصال الإنترنت على هاتفك'));
        else
          emit(LoginError(errorMessage: 'متجر غير مسجل'));
      });
    }
  }

  String validateInputs(String email, String password) {
    if (email.isEmpty && password.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      return 'قم بإدخال إيميل المتجر الخاص والرقم السرى';
    } else if (!email.trim().contains('@'))
      return 'قم بإدخال إيميل المتجر بطريقة صحيحة';
    else if (password.length < 8)
      return 'الرقم السرى قصير جدا';
    else
      return '';
  }
}
