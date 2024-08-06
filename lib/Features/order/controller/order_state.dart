
import '../data/order_model.dart';

abstract class OrderState{}
class OrderStateInitial extends OrderState{}
class MakeOrderSuccess extends OrderState {
 final String orderNo ;

  MakeOrderSuccess({required this.orderNo});
}
class MakeOrderFailure extends OrderState{}
class MakeOrderLoading extends OrderState{}




class GetOrderSuccess extends OrderState {
 final  List<OrderModel> allOrders ;
 final List<OrderModel> completedOrders ;
 final List<OrderModel> onGoingOrders ;
  GetOrderSuccess({required this.allOrders, required this.completedOrders, required this.onGoingOrders});
}
class GetOrderFailure extends OrderState{}
class GetOrderLoading extends OrderState{}




class GetOrderByIDSuccess extends OrderState{
 final OrderModel order ;

  GetOrderByIDSuccess({required this.order});
}
class GetOrderByIDFailure extends OrderState{
 final String errorMessage  ;

  GetOrderByIDFailure({required this.errorMessage});

}
class GetOrderByIDLoading extends OrderState{}