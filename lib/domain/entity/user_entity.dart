class UserEntity {
  final String email;
  final String name;
  final String phone;
  final String id;
  final String image;

  const UserEntity(
      {required this.image,
      required this.email,
      required this.name,
      required this.phone,
      required this.id});
}
