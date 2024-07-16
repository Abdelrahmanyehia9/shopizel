
import '../../cart/data/model/cart_model.dart';

class OrderFeesRepo {

static double total  =   0  ;

  static bool isThereDiscount(List<CartModel> cart){
    for (int i  = 0 ; i < cart.length ; i ++){

      if(cart[i].sale!="0"){
        return true ;
      }


    }
    return false ;

  }
  static double calcService({required double price}){
    double serviceFees =  price > 1000 ? price * 0.01 : price * 0.015 ;
    if (serviceFees < 5){
      return 4.99 ;
    }else if (serviceFees > 100){
      return 99.99 ;
    }else {
      return serviceFees ;
    }
  }
static double calcTotal ({required double order ,required double discount ,required double shipping ,required double service ,required double promoCode }){

    return order - discount +shipping +service - promoCode  ;


}





}