import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/order/controller/order_state.dart';
import 'package:shoppizel/Features/order/data/order_repo.dart';
import 'package:shoppizel/Features/promo/data/promo_model.dart';

import '../data/order_model.dart';

class OrderCubit extends Cubit<OrderState>{
  final OrderRepo repo ;

  OrderCubit(this.repo):super(OrderStateInitial()) ;

  Future<void> makeAnOrder({required OrderModel order , PromoModel? promo })async{
    emit(MakeOrderLoading()) ;
    try {
     String orderNo = await repo.placeAOrder(order: order , promo: promo) ;
      emit(MakeOrderSuccess(orderNo: orderNo)) ;
    }catch(e){
      emit(MakeOrderFailure()) ;
      print(e.toString()) ;
    }



  }
  Future<void>getOrders ()async{
    emit(GetOrderLoading()) ;
       try{
         List<OrderModel>allOrders = await  repo.getAllOrders() ;
         List<OrderModel>completedOrders = repo.getCompletedOrders(allOrders) ;
         List<OrderModel>onGoingOrders = repo.getOnGoingOrders(allOrders) ;
         emit(GetOrderSuccess(allOrders: allOrders, completedOrders: completedOrders, onGoingOrders: onGoingOrders)) ;
       }catch(e){
         emit(GetOrderFailure()) ;
         print(e.toString()) ;
       }
  }


}