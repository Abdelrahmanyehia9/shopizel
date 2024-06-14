import 'package:shoppizel/Features/home/data/model/product_model.dart';

import '../model/store_model.dart';

class StoreRepo {
  final List<ProductModel> storeCollection ;
  StoreRepo({required this.storeCollection});

List<ProductModel> getGenderClothes( String gender)  {

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
return pop.reversed.toList();


}
List<ProductModel>getBigSaleProducts(List<ProductModel> model){

  List<ProductModel> sale =model ;
  sale.sort((a, b) => int.parse(a.sale??"0").compareTo(int.parse(b.sale??"0")));
  return sale.reversed.toList();



}
List<ProductModel>topRatedProducts(List<ProductModel> model){

    List<ProductModel> topRated = model ;
    topRated.sort((a, b) => double.parse(a.rate??"0").compareTo(double.parse(b.rate??"0")));
    return topRated.reversed.toList();



  }
  List<ProductModel> getSpecificTypeOfClothes({required String type}){
  List<ProductModel> model  = []  ;
  for(int i = 0 ; i < model.length ; i++ ){

    if (storeCollection[i].type == type){

      model.add(storeCollection[i])  ;
    }





  }
  return model ;
  }
  List<ClothesCategory> getClothesCategoryOfGender({ String? gender , required StoreModel model}){
  List<ClothesCategory> cat =[] ;


  for(int i =  0  ; i< model.clothesCategory.length  ; i++ ){
    if(model.clothesCategory[i].gender == gender){
      cat.add(model.clothesCategory[i]) ;
    }
    else if (gender == null){

      cat.add(model.clothesCategory[i]) ;
    }



  }

  return cat ;


  }

}