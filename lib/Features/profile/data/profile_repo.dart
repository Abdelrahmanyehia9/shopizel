import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoppizel/Features/location/data/model.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

import '../../Auth/data/model/user_model.dart';

class ProfileRepo {

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;


  Future<UserModel> getProfileInfo() async {
    List<LocationModel> locations = [];
    var response = await _fireStore.collection(FirebaseConstant.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var responseLocation = await _fireStore.collection(
        FirebaseConstant.usersCollection).doc(
        FirebaseAuth.instance.currentUser!.uid).collection("location").get() ;
    UserModel userInfo = UserModel.fromJson(response.data()!);
    for(int i = 0 ; i< responseLocation.docs.length ; i ++ ){

      locations.add(LocationModel.fromJson(responseLocation.docs[i].data())) ;

    }
    return userInfo ;

  }
  Future<void>editProfile(UserModel user) async{
    await _fireStore.collection(FirebaseConstant.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).update(user.toJson()) ;
    await FirebaseAuth.instance.currentUser!.updateDisplayName(user.username) ;
  }
  Future<void>updateImg({required File image})async{
String imgName = FirebaseAuth.instance.currentUser!.uid  ;
Reference storage = FirebaseStorage.instance.ref("images/$imgName.jpg") ;
await storage.putFile(image) ;
String downloadedImg = await storage.getDownloadURL() ;
FirebaseFirestore.instance.collection(FirebaseConstant.usersCollection).doc(imgName).update({"profilePic":downloadedImg})  ;
  }
  Future<void>deleteProfilePic()async{
await _fireStore.collection(FirebaseConstant.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).update({"profilePic":null});

  }


}