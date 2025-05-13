class UserModel {
  final String name;
  final String email;
  final String userId;

  UserModel({required this.name, required this.email, required this.userId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      userId: json['\$id'],
    );
  }
}
