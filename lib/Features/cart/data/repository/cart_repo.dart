import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppizel/Features/cart/data/model/cart_model.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';

class CartRepo {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<CartModel>> getCartProducts() async {
    List<CartModel> model = [];
    var response = await _fireStore
        .collection(FirebaseConstant.usersCollection)
        .doc(_auth.currentUser!.uid)
        .collection(FirebaseConstant.cartCollection)
        .get();

    for (int i = 0; i < response.docs.length; i++) {
      model.add(CartModel.fromJson(response.docs[i].data()));
    }
    return model;
  }
  Future<void> addToCart(CartModel model) async {
    var response = await _fireStore.collection(FirebaseConstant.usersCollection)
        .doc(_auth.currentUser!.uid).collection(FirebaseConstant.cartCollection)
        .doc("${model.productId.toString()}${model.size}${model.color}").get();
    if (response.data() == null) {
      await _fireStore.collection(FirebaseConstant.usersCollection).doc(
          _auth.currentUser!.uid)
          .collection(FirebaseConstant.cartCollection)
          .doc("${model.productId.toString()}${model.size}${model.color}").set(model.toJson()) ;
    } else {
      int quantity = await response.get("quantity");
      await _fireStore.collection(FirebaseConstant.usersCollection).doc(
          _auth.currentUser!.uid)
          .collection(FirebaseConstant.cartCollection)
          .doc("${model.productId.toString()}${model.size}${model.color}")
          .update({"quantity":quantity+1}) ;
    }
  }
  List<String> getStoresOfProducts(List<CartModel> model) {
    List<String> stores = [];
    for (CartModel store in model) {
      stores.add(store.madeBy);
    }

    return stores;
  }
  Future<void> removeFromCart(CartModel model) async {
    var response = await _fireStore.collection(FirebaseConstant.usersCollection)
        .doc(_auth.currentUser?.uid).collection(FirebaseConstant.cartCollection)
        .get();
    for (int i = 0; i < response.docs.length; i ++) {
      if (response.docs[i].get("productId") == model.productId &&
          response.docs[i].get("size") == model.size &&
          response.docs[i].get("color") == model.color) {
        await _fireStore.collection(FirebaseConstant.usersCollection).doc(
            _auth.currentUser?.uid)
            .collection(FirebaseConstant.cartCollection)
            .doc(response.docs[i].id)
            .delete();
      }
    }
  }
int getCartCount(List<CartModel> carts){
    int count  = 0 ;
    for(int i =0 ; i<carts.length ; i++){

      count+=carts[i].quantity ;



    }

    return count ;



}
Future<void>getCartEmpty()async{

  final CollectionReference reference =   _fireStore.collection(FirebaseConstant.usersCollection).doc(_auth.currentUser!.uid).collection(FirebaseConstant.cartCollection) ;
  final QuerySnapshot snapshot = await reference.get();

  for (DocumentSnapshot doc in snapshot.docs) {
    await doc.reference.delete();
  }
}
 Future<void>increaseAndDecreaseQuantity(CartModel model , bool isAdded)async{
   var response =await _fireStore.collection(FirebaseConstant.usersCollection).doc(_auth.currentUser!.uid).collection(FirebaseConstant.cartCollection)
       .doc("${model.productId.toString()}${model.size}${model.color}").get() ;

   int count = await response.get("quantity");
    if (isAdded){

      count++ ;
     await response.reference.update({"quantity":count}) ;

    }else{


        count --  ;
     await   response.reference.update({"quantity":count}) ;





    }




}
}
