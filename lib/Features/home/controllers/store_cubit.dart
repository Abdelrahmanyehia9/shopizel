import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/store_state.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

import '../data/model/product_model.dart';
import '../data/repository/store_repo.dart';

class StoreCubit extends Cubit<StoreState>{

final StoreRepo repo ;
  StoreCubit(this.repo):super(StoreStateInitial()) ;
List<ProductModel>men   =[]  ;
List<ProductModel>women   =[]  ;
List<ProductModel>kids   =[]  ;


Future<void> getCollection ({required String storeName ,}) async{
  emit(StoreStateLoading()) ;

  try{

   List<ProductModel> coll  = await repo.getStoreCollection(storeName: storeName) ;
   men = repo.getGenderClothes(FirebaseConstant.menClothes, coll) ;
   women = repo.getGenderClothes(FirebaseConstant.womenClothes, coll) ;
   kids = repo.getGenderClothes(FirebaseConstant.kidsClothes, coll) ;
   emit(StoreStateSuccess(coll)) ;

  }catch(e){

    emit(StoreStateFailure()) ;

  }



}




}