class UserModel {
  final int uid;
  final String username;
  final String email;

  UserModel({
    required this.username,
    required this.email,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      uid: json['id'],
    );
  }
}
