import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppizel/Features/order/data/order_model.dart';
import 'package:shoppizel/Features/promo/data/promo_model.dart';


class OrderRepo{

 final  FirebaseFirestore _fireStore = FirebaseFirestore.instance ;

  Future<void>placeAOrder(OrderModel order )async{
  var res =   await _fireStore.collection("orders").add(order.toJson()) ;
  await res.update({"orderId":res.id}) ;
  }
  
  Future<List<OrderModel>>getAllOrders ()async{
   List<OrderModel> orders = []  ;
   var response = await _fireStore.collection("orders").where("user.email" , isEqualTo: FirebaseAuth.instance.currentUser!.email).get() ;
   for(int i = 0 ; i < response.docs.length ; i ++ ){
   orders.add(OrderModel.fromJson(response.docs[i].data())) ;
  }
   return orders ;

  }
  List<OrderModel>getCompletedOrders(List<OrderModel> allOrders){
   List<OrderModel> completed  = []  ;
   for(OrderModel order in allOrders){
    if(order.orderStatus == "Completed"){
     completed.add(order) ;
    }

   }
   return completed ;

  }
 List<OrderModel>getOnGoingOrders(List<OrderModel> allOrders){
  List<OrderModel> onGoing  = []  ;
  for(OrderModel order in allOrders){
   if(order.orderStatus == "Accepted"){
    onGoing.add(order) ;
   }

  }
  return onGoing ;

 }




}



