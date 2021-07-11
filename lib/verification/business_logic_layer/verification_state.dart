import 'package:store_go/verification/data_layer/data_model/account_info_response.dart';
import 'package:store_go/verification/data_layer/data_model/banks_info_response.dart';
import 'package:equatable/equatable.dart';

abstract class VerificationState extends Equatable {}

class VerificationInitial extends VerificationState {
  @override
  List<Object> get props => [];
}

class AccountInfoError extends VerificationState {
  final String errorMessage;

  AccountInfoError({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class LogoutError extends VerificationState {
  final String errorMessage;

  LogoutError({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class Loading extends VerificationState {
  @override
  List<Object> get props => [];
}

class ConnectionTimeout extends VerificationState {
  final String timeoutMessage;

  ConnectionTimeout({this.timeoutMessage});
  @override
  List<Object> get props => [timeoutMessage];
}

class LogoutSuccess extends VerificationState {
  @override
  List<Object> get props => [];
}

class AccountInfoSuccess extends VerificationState {
  final Data accountInformation;
  final List<Datum> banksList;

  AccountInfoSuccess(this.accountInformation, this.banksList);
  @override
  List<Object> get props => [accountInformation, banksList];
}
