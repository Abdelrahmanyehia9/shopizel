import 'package:shoppizel/Features/Machine/robot/data/model/clothes_measure_model.dart';

String predictSize({required double height  , required double weight , required ClothesMeasureModel model}){
  double bmi = weight-(height-100) ;
   double score = model.score +bmi ;
   print(bmi);
   if(score < 200){
     return "S" ;
   }else if (200 < score && score < 215){
     return "M" ;
   }else if (215< score && score < 230){
     return "L" ;
   }else if (230<score && score < 255){
     return "XL" ;
   }else if (255 < score && score < 280){
     return "XXL" ;
   }else if(280 < score && score < 305){
     return "XXXL" ;
   }else if (305 < score && score < 335){
     return "XXXXL" ;
   }else{
     return "Not available" ;
   }
}