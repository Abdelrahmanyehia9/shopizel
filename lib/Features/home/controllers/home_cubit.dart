import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/home_states.dart';
import 'package:shoppizel/Features/home/data/model/category_model.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';

import '../data/model/store_model.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit(this.repo):super (HomeStateInitial()) ;

  final HomeRepo repo ;


  Future<void> fetch()async{
    emit( HomeStateLoading()) ;
    try{
     List<CategoryModel> models = await repo.getCategories() ;
     List<StoreModel> storeModel = await repo.getStores() ;

     emit(HomeStateSuccess(categories: models , stores: storeModel )) ;
    }catch(e){

      emit(HomeStateFailure(e.toString())) ;


    }
  }



}