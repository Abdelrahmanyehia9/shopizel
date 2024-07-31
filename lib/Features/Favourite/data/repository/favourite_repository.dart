import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';

class FavouriteRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> checkProductIfFavourite(int id) async {
    var response = await _firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(_auth.currentUser!.uid)
        .collection(FirebaseConstant.favouriteCollection)
        .get();
    bool isFav = false;
    for (int i = 0; i < response.docs.length; i++) {
      if (id == response.docs[i].get("id")) {
        return true;
      } else {
        isFav = false;
      }
    }
    return isFav;
  }
  Future<void> addToFavourite({required ProductModel model}) async {
    await _firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(_auth.currentUser?.uid)
        .collection(FirebaseConstant.favouriteCollection)///
        .doc(model.id.toString())
        .set(model.toJson());
    await _firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(_auth.currentUser?.uid)
        .collection(FirebaseConstant.favouriteCollection)
        .doc(model.id.toString())
        .update({"dateOfAdded":DateTime.now().toString()});
  }
  Future<void> removeFromFavourite({required int id}) async {
    await _firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(_auth.currentUser?.uid)
        .collection(FirebaseConstant.favouriteCollection)
        .doc(id.toString())
        .delete();
  }
  Future<List<ProductModel>> getAllFavourite() async {
    List<ProductModel> favourites = [];
    var response = await _firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(_auth.currentUser!.uid)
        .collection(FirebaseConstant.favouriteCollection)
        .get();
    for (int i = 0; i < response.docs.length; i++) {
      favourites.add(ProductModel.fromJson(response.docs[i].data()));
    }
    return favourites;
  }
}
