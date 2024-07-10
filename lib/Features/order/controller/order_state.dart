
import '../data/order_model.dart';

abstract class OrderState{}
class OrderStateInitial extends OrderState{}
class MakeOrderSuccess extends OrderState {}
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