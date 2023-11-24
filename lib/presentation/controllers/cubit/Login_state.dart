part of 'Login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {
}

class LoginLoadedState extends LoginState {
  final String id;

  LoginLoadedState(this.id);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordState extends LoginState {}
