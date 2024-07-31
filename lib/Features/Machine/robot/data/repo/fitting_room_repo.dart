import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoppizel/core/database/remote/api_helper.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';

import '../../../../home/data/model/product_model.dart';

class FittingRoomRepo {

final ApiHelper helper ;
FittingRoomRepo({required this.helper});

Future<String?> fetch({required String humanImg, required String clothImg}) async {

     var response = await helper.post("/process", {
       "background": humanImg,
       "garm_img": clothImg
     }, "application/json");
     if (response != null ){
       return response["output_file"] ;
     }


}Future<List<ProductModel>>getTopProducts ()async{
   List<ProductModel> products = []  ;
  var response = await FirebaseFirestore.instance.collection(FirebaseConstant.productsCollections).get() ;
  for(int i = 0 ; i < response.docs.length ; i++){
    String type = await response.docs[i].get("type") ;
    if (type != FirebaseConstant.pants &&type != FirebaseConstant.shoes &&type != FirebaseConstant.skirt){
      products.add(ProductModel.fromJson(response.docs[i].data())) ;

    }

  }
  return products ;
} 


}