import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoppizel/Features/location/data/model.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';
import 'package:shoppizel/core/function/permission_handlers.dart';

class LocationRepo {
  Dio dio = Dio();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getLocationName(
      {required String lat, required String long}) async {
    var response = await dio.get(
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$long");
    if (response.statusCode == 200) {
      return await response.data["display_name"];
    } else {
      return "";
    }
  }

  static Future<Position> determineDevicePosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> addToLocation(LocationModel locationModel) async {
    await _firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("location")
        .doc(locationModel.name)
        .set(locationModel.toJson());
    await selectLocation(locationModel);
  }

  Future<List<LocationModel>> getAllLocations() async {
    List<LocationModel> locations = [];
    var response = await _firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("location")
        .orderBy("dateOfAdded", descending: true)
        .get();

    for (int i = 0; i < response.docs.length; i++) {
      locations.add(LocationModel.fromJson(response.docs[i].data()));
    }
    return locations;
  }

  LocationModel? getSelectedLocation(List<LocationModel> locations) {
LocationModel? model  ;
    for (LocationModel item in locations) {
      if (item.isSelected == true) {
        model = item ;
      }
    }
    return model ;
  }

  Future<void> selectLocation(LocationModel model) async {
    var response = await _firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("location")
        .get();
    for (int i = 0; i < response.docs.length; i++) {
      if (await response.docs[i].get("name") != model.name) {
        await _firestore
            .collection(FirebaseConstant.usersCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("location")
            .doc(response.docs[i].id)
            .update({"isSelected": false});
      } else {
        await _firestore
            .collection(FirebaseConstant.usersCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("location")
            .doc(response.docs[i].id)
            .update({"isSelected": true});
      }
    }
  }
  Future<void> deleteSelectedItem(LocationModel model) async {
    try{
      _firestore.collection(FirebaseConstant.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection("location").doc(model.name).delete() ;

    }catch(e){
      print(e.toString()) ;
    }
  }
}
