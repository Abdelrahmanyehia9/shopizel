import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

import '../model/store_model.dart';

class StoreRepo {

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance ;
  Future<List<ProductModel>>getStoreCollection({required String storeName})async{
List<ProductModel> collection = []  ;
    QuerySnapshot<Map<String, dynamic>> response = await _firebaseFireStore.collection(FirebaseConstant.productsCollections).where(FirebaseConstant.productMadeBy ,isEqualTo:  storeName).get() ;
    
    for(int i = 0 ; i< response.docs.length ; i++){


      collection.add(ProductModel.fromJson(response.docs[i].data()));


    }
    
    
    
    
    return  collection ;
    
    
  }
List<ProductModel> getGenderClothes( String gender , List<ProductModel>storeCollection)  {

  List<ProductModel> model = [] ;
  for(int i = 0 ; i < storeCollection.length ; i++){

    if (storeCollection[i].category == gender){
      model.add(storeCollection[i]) ;
    }
  }


  return model ;


}
List<ProductModel> getPopularClothes(List<ProductModel> model){

List<ProductModel> pop = model ;
pop.sort((a, b) => int.parse(a.count).compareTo(int.parse(b.count)));
return pop.reversed.toSet().toList();


}
List<ProductModel>getBigSaleProducts(List<ProductModel> model){

  List<ProductModel> sale =model ;
  sale.sort((a, b) => int.parse(a.sale??"0").compareTo(int.parse(b.sale??"0")));
  return sale.reversed.toSet().toList();



}
List<ProductModel>topRatedProducts(List<ProductModel> model){

    List<ProductModel> topRated = model ;
    topRated.sort((a, b) => double.parse(a.rate??"0").compareTo(double.parse(b.rate??"0")));
    return topRated.reversed.toSet().toList();



  }
  List<ProductModel>getNewestClothes(List<ProductModel> collection){
    List<ProductModel> newest = collection ;
    DateTime oldDate = DateTime(2020, 1, 1);
    newest.sort((a, b) {
      DateTime dateA = a.dateTime != null ? DateTime.parse(a.dateTime!) : oldDate;
      DateTime dateB = b.dateTime != null ? DateTime.parse(b.dateTime!) : oldDate;
      return dateB.compareTo(dateA);
    });
    return newest.toSet().toList() ;

  }
  List<String>getGenderClothCategories( List<ProductModel> collection){
    List<String> a = [] ;
    for(int i = 0 ; i  < collection.length ; i ++ )
    {
      a.add(collection[i].type) ;

    }
    return a.toSet().toList() ;
  }


}