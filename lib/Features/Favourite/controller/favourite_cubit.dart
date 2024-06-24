import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_state.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';

class FavouriteCubit extends Cubit<FavouriteStates>{

  FavouriteCubit(this.repo):super(GetFavouriteStateInitial()) ;
  final FirebaseAuth _auth = FirebaseAuth.instance ;
  final FavouriteRepo repo ;



Future<void> fetchFavourite()async{

    if (_auth.currentUser == null ){

      emit(GetFavouriteStateFailure(errorMsg: "You Should Sign up To See your Favourite")) ;


    }else {
      emit(GetFavouriteStateLoading()) ;
      try{
       List<ProductModel> favourites =  await repo.getAllFavourite();
emit(GetFavouriteStateSuccess(favourites: favourites)) ;
      }catch(e){
        emit(GetFavouriteStateFailure(errorMsg: e.toString())) ;
      }

    }
}






}