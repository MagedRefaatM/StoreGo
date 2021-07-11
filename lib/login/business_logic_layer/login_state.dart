import 'package:store_go/login/data_layer/data_model/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class InvalidInputs extends LoginState {
  final String errorMessage;

  InvalidInputs({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class Loading extends LoginState {
  @override
  List<Object> get props => [];
}

class ConnectionTimeout extends LoginState {
  final String timeoutMessage;

  ConnectionTimeout({this.timeoutMessage});
  @override
  List<Object> get props => [timeoutMessage];
}

class LoginSuccess extends LoginState {
  final LoginData loginInfo;

  LoginSuccess(this.loginInfo);
  @override
  List<Object> get props => [loginInfo];
}
