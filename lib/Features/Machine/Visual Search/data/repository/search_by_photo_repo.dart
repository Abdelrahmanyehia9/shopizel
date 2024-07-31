
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/data/model/visual_search_model.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/database/remote/api_helper.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';

class SearchByPhotoRepo {


final  ApiHelper helper ;
  SearchByPhotoRepo(this.helper);

Future<List<VisualSearchModel>?> search(String desc)async{

  Map<String  ,  dynamic>? response = await helper.post("/similarity", {"description":desc} , "application/json") ;
  List<VisualSearchModel> predicted = [] ;
  if (response != null ){
     for (var item in response['results']){
       predicted.add(VisualSearchModel.fromJson(item)) ;
     }


return predicted ;

  }





}
Future<List<ProductModel>>productSearch(List<VisualSearchModel> predict)async{

  List<ProductModel>products = [] ;
  for (var item in predict){

    var response =  await FirebaseFirestore.instance.collection(FirebaseConstant.productsCollections).doc(item.docId).get();
    products.add(ProductModel.fromJson(response.data()!)) ;
  }


  return products ;
}



}



