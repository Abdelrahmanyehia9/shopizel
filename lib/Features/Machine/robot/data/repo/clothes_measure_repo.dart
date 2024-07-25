import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppizel/core/database/api_helper.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

import '../../../../home/data/model/product_model.dart';
import '../model/clothes_measure_model.dart';

class ClothesMeasureRepo {
  
 final  ApiHelper helper  ;
 ClothesMeasureRepo({required this.helper}); 
  
 Future<ClothesMeasureModel?>measure({required String img ,required double height })async{
   var response  = await helper.post("/measurements", {"image":img ,
     "height": height
   }, "application/json") ;
   if (response != null ){

     return ClothesMeasureModel.fromJson(response) ;
   }
   
   
   
 }
 Future<List<ProductModel>> getMeasureProduct(String size) async {
   var response = await FirebaseFirestore.instance
       .collection(FirebaseConstant.productsCollections)
       .get();

   List<ProductModel> products = response.docs
       .map((doc) => ProductModel.fromJson(doc.data()))
       .toList();

   return products.where((product) => product.sizes.contains(size)).toList();
 }
}