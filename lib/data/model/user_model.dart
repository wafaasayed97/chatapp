import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String image,
    required String email,
    required String name,
    required String phone,
    required String id,
  }) : super(
    image: image,
    email: email,
    name: name,
    phone: phone,
    id: id,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json['email'],
    name: json['name'],
    phone: json['phone'],
    id: json['id'],
    image: json['image'],
  );

  Map<String, dynamic> toMap() => {
  'name': name,
  "email": email,
  "id": id,
  "phone": phone,
  "image": image,
  };


}