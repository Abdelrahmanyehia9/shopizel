import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppizel/Features/rate/data/rate_model.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

import '../../home/data/model/product_model.dart';

class RateRepo {


final  FirebaseFirestore _fireStore = FirebaseFirestore.instance ;


  Future<void> addRating (List<RateModel> rates ) async{
    for(RateModel item in rates){

      await _fireStore.collection("rates").add(item.toJson()) ;

    }




  }
Future<List<RateModel>>getAllMyRates()async{
    List<RateModel>myRates = [] ;
    var response = await _fireStore.collection("rates").where("rateBy.uid" , isEqualTo: FirebaseAuth.instance.currentUser!.uid).get() ;

    for(int i = 0 ; i< response.docs.length ; i++ ){

      myRates.add(RateModel.fromJson(response.docs[i].data())) ;

    }
    myRates.sort((a , b) => a.dateRates.compareTo(b.dateRates)) ;
    return myRates.reversed.toList();
    
    
}
Future<List<RateModel>>getProductRate(ProductModel model) async{

    List<RateModel>rates = [] ;
 var response =    await _fireStore.collection("rates").where("product.producId" , isEqualTo:model.id ).get() ;
 for(int i = 0 ; i < response.docs.length ; i++ ){
   rates.add(RateModel.fromJson(response.docs[i].data())) ;
 }
 return rates ;
}


}