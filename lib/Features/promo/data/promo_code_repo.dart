import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppizel/Features/promo/data/promo_model.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';

class PromoCodeRepo{

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance ;

  Future<List<PromoModel>> getAllPromo()async{
    List<PromoModel> promoCodes = [] ;
    var response = await _fireStore.collection(FirebaseConstant.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection("promo").get() ;
    for(int i = 0 ; i < response.docs.length ; i++){

      promoCodes.add(PromoModel.fromJson(response.docs[i].data())) ;

    }
    return promoCodes ;
  }
  Future<PromoModel?> applyPromo(String code)async{
    var response = await _fireStore.collection(FirebaseConstant.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection("promo").where("code" , isEqualTo: code).get() ;
    if (response.docs.isNotEmpty){
      return PromoModel.fromJson(response.docs.first.data()) ;
    }else{
      return null ;
    }

  }
Future<void> addNewPromo (PromoModel model )async{
    await _fireStore.collection(FirebaseConstant.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection("promo").add(model.toJson()) ;


}












}