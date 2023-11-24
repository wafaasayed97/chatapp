import 'package:chat_app/data/model/user_model.dart';

class LoginEntity{
  final bool status;
  final String message ;
   UserModel ?data;

  LoginEntity({required this.status, required this.message, this.data});
}