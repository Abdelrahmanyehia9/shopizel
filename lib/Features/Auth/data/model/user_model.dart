class UserModel {
  final String username;
  final String password;
  final String uid;
  final String email;

  UserModel(
      {required this.uid,
      required this.username,
      required this.password,
      required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["uid"],
      username: json['username'],
      password: json["password"],
      email: json["email"]);

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "password": password,
      "email": email,
    };
  }
}
