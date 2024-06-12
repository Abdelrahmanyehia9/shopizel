class UserModel {
  final String? username;
  final String uid;
  final String email;
  final String? lat ;
  final String? long ;

  UserModel(
      {required this.uid,
       this.username,
      required this.email,
      this.lat , this.long});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["uid"],
      username: json['username'],
      email: json["email"] ,
  lat: json["latitude"] ,
  long:  json['longitude']);

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "latitude":lat ,
      "longitude":long,
    };
  }
}
