part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterLoadedState extends RegisterState {}
class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}
class CreateUserLoadedState extends RegisterState {}
class CreateUserErrorState extends RegisterState {
  final String error;

  CreateUserErrorState(this.error);
}

class RegisterChangePasswordState extends RegisterState {}

