import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppizel/Features/rate/data/rate_model.dart';

class RateRepo {


final  FirebaseFirestore _fireStore = FirebaseFirestore.instance ;


  Future<void> addRating (List<RateModel> rates ) async{
    for(RateModel item in rates){

      await _fireStore.collection("rates").add(item.toJson()) ;


    }




  }



}