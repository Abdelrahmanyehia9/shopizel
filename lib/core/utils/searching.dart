import '../../Features/home/data/model/product_model.dart';
import '../../Features/home/data/model/store_model.dart';

class Searching {


 static StoreModel? searchOnStore({required String search, required List<StoreModel> stores}) {
    List<String> words = search.split(" ");
    words.toSet().toList();

    for(int i = 0 ; i < stores.length ;  i ++ ){
      for(int j = 0 ; j< words.length ; j ++){
        if(stores[i].name.toLowerCase().contains(words[j].toLowerCase())){
          return stores[i] ;
        }
      }
    }

  }
 static List<ProductModel>searchOnProduct({required String search , required List<ProductModel>products }){
   List<ProductModel> searchingResults  = [] ;
   List<String> searchText = search.split(" ").toSet().toList() ;
   for (int i = 0  ; i < products.length ; i ++){
     for(int  j = 0 ; j < searchText.length ; j++){
       if(products[i].name.toLowerCase().contains(searchText[j].toLowerCase()) || products[i].desc.toLowerCase().contains(searchText[j].toLowerCase()) || products[i].type.toLowerCase().contains(searchText[j].toLowerCase())
           || products[i].madeBy.toLowerCase().contains(searchText[j].toLowerCase())
       ){
         searchingResults.add(products[i]) ;
       }







     }









   }
   return searchingResults.toSet().toList( ) ;
 }

}
