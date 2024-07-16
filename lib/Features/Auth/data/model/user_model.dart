import '../../../location/data/model.dart';

class UserModel {
  final String? username;
  final String uid;
  final String email;
  final String? number ;
   String? profilePic ;
  final List<LocationModel>? location ;


  UserModel(
      {required this.uid,
       this.username,
      required this.email,
        this.number , this.location , this.profilePic
    });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["uid"],
      username: json['username'],
      email: json["email"] ,
      number:json['number'] ,
    profilePic:  json["profilePic"]
);

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "number":number ,

    };
  }
}
