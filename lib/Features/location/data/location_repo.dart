 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoppizel/Features/location/data/model.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

 class LocationRepo{

Dio dio = Dio() ;

final FirebaseFirestore _firestore = FirebaseFirestore.instance ;

 Future<String> getLocationName({required String lat , required String long})async{
 var response =  await dio.get("https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$long") ;
  if (response.statusCode == 200){

    return await response.data["display_name"];
  }else{

    return "";
  }

}
   static Future<Position> determineDevicePosition() async {
     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   }
 Future<void>addToLocation(LocationModel locationModel)async{
    await _firestore.collection(FirebaseConstant.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection("location").
   doc(locationModel.name).set(locationModel.toJson());
 }










 }


