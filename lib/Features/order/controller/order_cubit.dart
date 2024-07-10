import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/order/controller/order_state.dart';
import 'package:shoppizel/Features/order/data/order_repo.dart';

import '../data/order_model.dart';

class OrderCubit extends Cubit<OrderState>{
  final OrderRepo repo ;

  OrderCubit(this.repo):super(OrderStateInitial()) ;

  Future<void> makeAnOrder(OrderModel order)async{
    emit(MakeOrderLoading()) ;
    try {
      repo.placeAOrder(order) ;
      emit(MakeOrderSuccess()) ;
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