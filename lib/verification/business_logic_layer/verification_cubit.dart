import 'package:store_go/verification/data_layer/repository/account_info_repo.dart';
import 'package:store_go/verification/business_logic_layer/verification_state.dart';
import 'package:store_go/verification/data_layer/repository/logout_repo.dart';
import 'package:store_go/verification/data_layer/repository/banks_repo.dart';
import 'package:bloc/bloc.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final _accountInfoRepo = AccountInformationRepository();
  final _logoutRepo = LogoutRepository();
  final _banksRepo = BanksRepository();

  VerificationCubit() : super(VerificationInitial());

  void logout() {
    emit(Loading());

    _logoutRepo.getLogoutResponse().then((logoutResponse) {
      if (logoutResponse != null)
        emit(LogoutSuccess());
      else if (logoutResponse == 0)
        emit(ConnectionTimeout(
            timeoutMessage: 'برجاء التحقق من إتصال الإنترنت على هاتفك'));
      else
        emit(LogoutError(errorMessage: 'حدث خطأ ما، برجاء إعادة المحاولة'));
    });
  }

  void getAccountInfo() {
    emit(Loading());

    _accountInfoRepo.getAccountInfo().then((accountInfo) {
      if (accountInfo != null) {
        _banksRepo.getLoginResponse().then((banksList) {
          if (banksList != null)
            emit(AccountInfoSuccess(accountInfo, banksList));
          else if (banksList == 0)
            emit(ConnectionTimeout(
                timeoutMessage: 'برجاء التحقق من إتصال الإنترنت على هاتفك'));
          else
            emit(AccountInfoError(
                errorMessage: 'حدث خطأ ما، برجاء إعادة المحاولة'));
        });
      } else if (accountInfo == 0)
        emit(ConnectionTimeout(
            timeoutMessage: 'برجاء التحقق من إتصال الإنترنت على هاتفك'));
      else if (accountInfo == null)
        emit(
            AccountInfoError(errorMessage: 'حدث خطأ ما، برجاء إعادة المحاولة'));
    });
  }
}
