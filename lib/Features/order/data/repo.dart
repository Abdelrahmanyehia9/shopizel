import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppizel/Features/order/data/model.dart';


class OrderRepo{

 final  FirebaseFirestore _fireStore = FirebaseFirestore.instance ;

  Future<void>placeAOrder(OrderModel order )async{
    await _fireStore.collection("orders").add(order.toJson()) ;
  }


}



