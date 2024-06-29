import '../data/model/cart_model.dart';

abstract class CartStates{}
class CartStateLoading extends CartStates{}
class CartStateInitial extends CartStates {}
class CartStateFailure extends CartStates{
  final String error ;
  CartStateFailure({required this.error});
}
class CartStateSuccess extends CartStates {
  final List<CartModel> cartProducts ;
  final List<String> stores ;
  CartStateSuccess({required this.cartProducts , required this.stores});

}





class AddToCartLoading extends CartStates {}
class AddToCartSuccess extends CartStates {}
class AddToCartFailure extends CartStates {
  final String error  ;
  AddToCartFailure({required this.error});
}



class RemoveFromCartLoading extends CartStates {}
class RemoveFromCartSuccess extends CartStates {}
class RemoveFromCartFailure extends CartStates {
  final String error  ;
  RemoveFromCartFailure({required this.error});
}