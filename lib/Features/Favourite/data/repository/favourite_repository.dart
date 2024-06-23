import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

class FavouriteRepo {
final FirebaseAuth _auth = FirebaseAuth.instance ;
final   FirebaseFirestore _firestore = FirebaseFirestore.instance ;

Future<bool>checkIfValidToFavourite(ProductModel model )async {
  bool valid = false;

  var response = await _firestore.collection(FirebaseConstant.usersCollection)
      .doc(_auth.currentUser!.uid).collection(
      FirebaseConstant.favouriteCollection)
      .get();

  for (int i = 0; i < response.docs.length; i++) {
    if (model.id != int.parse(response.docs[i].id)) {

      valid = true ;

    }else{

      return false ;
    }
  }
  return valid ;
}










  Future<void>addToFavourite({required ProductModel model})async{


    if (await checkIfValidToFavourite(model) ){



await _firestore.collection(FirebaseConstant.usersCollection).doc(_auth.currentUser?.uid).collection(FirebaseConstant.favouriteCollection).add(model.toJson());



    }







  }












}