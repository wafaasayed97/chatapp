
import 'package:chat_app/data/model/user_model.dart';

import '../../domain/entity/log_in_entity.dart';

class LoginModel extends LoginEntity{
  LoginModel({required super.status, required super.message, super.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json['status'],
    message: json['message'],
    data: json['data']!=null ?UserModel.fromJson(json['data']):null,

  );

  Map<String, dynamic> toMap() => {
    'status': status,
    "message": message,
    "data": data,
  };
}
