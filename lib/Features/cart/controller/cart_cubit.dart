import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/cart/controller/cart_state.dart';
import 'package:shoppizel/Features/cart/data/repository/cart_repo.dart';

import '../data/model/cart_model.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit(this.cartRepo) : super(CartStateInitial());


  final CartRepo cartRepo;

  Future<void> fetchCartProducts() async {
    emit(CartStateLoading());
    try {
      List<CartModel> cartProducts = await cartRepo.getCartProducts();
      List<String> stores =
          cartRepo.getStoresOfProducts(cartProducts).toSet().toList();
      emit(CartStateSuccess(cartProducts: cartProducts, stores: stores));
    } catch (e) {
      emit(CartStateFailure(error: e.toString()));
    }
  }
  Future<void> addToCart(CartModel model) async {
    emit(AddToCartLoading());
    try {
      await cartRepo.addToCart(model);
      emit(AddToCartSuccess());
    } catch (e) {
      emit(AddToCartFailure(error: e.toString()));
    }
  }
  List<CartModel> getProductByStore(String storeName , List<CartModel> products){
    List<CartModel> coll  = [] ;
    for(CartModel model in products ){
      if(model.madeBy == storeName){
        coll.add(model) ;
      }
    }
    return coll ;
  }
  Future<void>removeFromCart(CartModel model)async{
    emit(RemoveFromCartLoading()) ;
    try{
      await cartRepo.removeFromCart(model) ;
      emit(RemoveFromCartSuccess()) ;

    }catch(e){
      emit(RemoveFromCartFailure(error: "Oops There was an error please try  again later")) ;

    }



  }
}
