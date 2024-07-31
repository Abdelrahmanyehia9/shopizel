import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppizel/core/database/remote/api_helper.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';

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
 Future<List<ProductModel>> getMeasureProduct({required String size , String? gender }) async {
   List<ProductModel> filered = [] ;
   var response = await FirebaseFirestore.instance
       .collection(FirebaseConstant.productsCollections)
       .get();

   List<ProductModel> products = response.docs
       .map((doc) => ProductModel.fromJson(doc.data()))
       .toList();
   print(gender) ;
   if(gender != null){
  filered = products.where((product) => product.category! == gender).toList();
return filered.where((product) => product.sizes.contains(size)).toList();
   }
   return products.where((product) => product.sizes.contains(size)).toList();
 }
}