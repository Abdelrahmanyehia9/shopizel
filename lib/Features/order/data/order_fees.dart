
import '../../cart/data/model/cart_model.dart';

class OrderFeesRepo {



  static bool isThereDiscount(List<CartModel> cart){
    for (int i  = 0 ; i < cart.length ; i ++){

      if(cart[i].sale!="0"){
        return true ;
      }


    }
    return false ;

  }
  static double calcService({required double price}){
    return price > 1000 ? price * 0.01 : price * 0.015 ;
  }
static double calcTotal ({required double order ,required double discount ,required double shipping ,required double service ,required double promoCode }){

    return order - discount +shipping +service - promoCode  ;


}





}