import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_state.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';

class FavouriteCubit extends Cubit<FavouriteStates>{

  FavouriteCubit(this.repo):super(AddFavouriteStateInitial()) ;
  final FirebaseAuth _auth = FirebaseAuth.instance ;
  final FavouriteRepo repo ;

  Future<void>addToFavourite(ProductModel model)
  async{
    if(_auth.currentUser!=null){
     emit(AddFavouriteStateLoading()) ;
      try{
        repo.addToFavourite(model: model) ;

        emit(AddFavouriteStateSuccess()) ;
      }catch(e){

        emit(AddFavouriteStateFailure(errorMsg: "This Product you have added before")) ;

      }
    }
    else{
      emit(AddFavouriteStateFailure(errorMsg: "you Should Sign in Before That"))  ;
    }
}








}