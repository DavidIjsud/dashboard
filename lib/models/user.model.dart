class UserModel {
  final String? name;
  final String? email;
  final String userId;
  final String? lastName;

  UserModel({required this.name, this.email, required this.userId, this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['name'], email: json['email'], userId: json['userId'], lastName: json['lastName']);
  }
}
