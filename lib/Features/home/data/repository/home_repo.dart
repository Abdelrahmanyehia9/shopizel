import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppizel/Features/home/data/model/category_model.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/data/model/store_model.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';


class HomeRepo{
  final FirebaseFirestore _fireStore =  FirebaseFirestore.instance ;


  Future<List<CategoryModel>>getCategories()async{
    List<CategoryModel> model  =[] ;
    QuerySnapshot<Map<String, dynamic>> allCategories = await _fireStore.collection(FirebaseConstant.categoriesCollection).get();

    for(int i = 0 ; i <allCategories.docs.length ; i++  ){
     model.add(   CategoryModel.fromJson(allCategories.docs[i].data()) ) ;
    }
return model  ;
  }
  Future<List<StoreModel>>getStores()async {
    List<StoreModel> model = [];
    QuerySnapshot<Map<String, dynamic>> allStores = await _fireStore.collection(
        FirebaseConstant.storeCollections).orderBy("rate" , descending: true) .get();

    for (int i = 0; i < allStores.docs.length; i++) {
      model.add(StoreModel.fromJson(allStores.docs[i].data()));
    }
    return model;
  }
  Future<List<ProductModel>> getAllProduct(String gender)async{
    QuerySnapshot<Map<String, dynamic>> allProduct = await  _fireStore.collection(FirebaseConstant.productsCollections).where(FirebaseConstant.gender , isEqualTo: gender).get() ;
    List<ProductModel> model = [] ;
    for(int i = 0 ; i< allProduct.docs.length ; i++){

      model.add(ProductModel.fromJson(allProduct.docs[i].data())) ;


    }
    return model ;
  }
  List<ProductModel> getStoreProducts(List<ProductModel> allProduct , String storeName ){
    List<ProductModel> storeProducts  =[]  ;
    for(int i =  0  ; i<allProduct.length ; i++){
      if(allProduct[i].madeBy == storeName){

        storeProducts.add(allProduct[i]) ;

      }

    }

    return storeProducts ;
  }
  List<String>getStoreShopCategories(StoreModel model ){
    List<String> f = [] ;
    for(var item in model.shopCategory) {
      f.add(item.name) ;
    }
    return f.toSet().toList() ;
  }



}