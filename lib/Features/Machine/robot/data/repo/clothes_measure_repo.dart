import 'package:shoppizel/core/database/api_helper.dart';

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
  
}