part of 'login_cubit.dart';

abstract class LoginState {
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}