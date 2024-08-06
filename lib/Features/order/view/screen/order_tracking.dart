import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shoppizel/Features/order/controller/order_cubit.dart';
import 'package:shoppizel/Features/order/data/order_fees.dart';
import 'package:shoppizel/Features/rate/view/widget/product_rate.dart';
import 'package:shoppizel/Features/rate/view/widget/rate_products.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import '../../data/order_model.dart';
import '../widget/order_status.dart';
import '../widget/products_in_order.dart';

class OrderTracking extends StatefulWidget {
  final String orderID ;
  const OrderTracking({super.key , required this.orderID ,});

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
late Stream<DocumentSnapshot> orderStatueStream ;

  @override
  void initState() {

    orderStatueStream  = FirebaseFirestore.instance.collection("orders").doc(widget.orderID).snapshots() ;
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: orderStatueStream,
      builder:(context  , AsyncSnapshot<DocumentSnapshot> snapshots) {

        if (snapshots.hasData){
          OrderModel orderModel = OrderModel.fromJson(snapshots.data!.data() as  Map<String  ,dynamic>) ;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Track your Order"),
              actions: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text("Help"),
                ),
              ],
            ),
            body: orderModel.orderStatus == "Accepted" ||orderModel.orderStatus == "Prepared" || orderModel.orderStatus == "Onway"  ?  Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    timeOfOrder(context , orderModel),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Order Statue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppConstants.secondColor),
                      ),
                    ),
                    OrderStatue(orderStatus: orderModel.orderStatus,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "${orderModel.products.length} Products in your Order",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    ProductsInOrder(products: orderModel.products),
                    const SizedBox(
                      height: 16,
                    ),
                    orderFees(orderModel),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: orderModel.orderStatus == "Accepted"?(){

                      }:null ,
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          disabledBackgroundColor: Colors.grey.withOpacity(0.4),
                          disabledForegroundColor: Colors.grey.shade600,
                          fixedSize: Size(screenWidth(context), 50)),
                      child: const Text(
                        "Cancel  Order",
                      ),
                    )
                  ],
                ),
              ),
            ) :  Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:  screenHeight(context) *.3 , width: screenWidth(context),
                    child: Image.asset("assets/images/pngwing.com (38).png"),

                    ) ,
                    SizedBox(height: 16,) ,

                    PrimaryButton(label: "Rate Order"  , onTap: (){
                      showModalBottomSheet(context: context, builder: (_)=> RateProducts(
                          rateBy: FirebaseAuth.instance.currentUser!.uid, products: orderModel.products, orderId: widget.orderID))  ;
                    },) ,
                    SizedBox(height: 8,) ,
                    PrimaryButton(label: "I haven't recived" , color: Colors.white,) ,




                  ],
                ),
              ),
            ) ,
          );

        }else{
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: AppConstants.appColor,),),
          ) ;
        }


      },
    );
  }

  Widget timeOfOrder(context , OrderModel orderModel) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: AppConstants.shadow),
        padding: const EdgeInsets.all(16),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('d, MMM yyyy').format(DateTime.parse(orderModel.dateOfOrder)),
              style: const TextStyle(color: AppConstants.appColor, fontSize: 18),
            ),
            const SizedBox(height: 8,) ,
            Text(
              "Arrive In : ${orderModel.time} | before ${DateFormat("h:m a").format(DateTime.parse(orderModel.dateOfOrder).add(const Duration(hours: 3)))}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: screenWidth(context)*.6,
                    child: Text("Order NO : #${orderModel.orderId}" , overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12 , fontWeight: FontWeight.bold),)),
                IconButton(icon:const Icon(Icons.copy_outlined) , onPressed: (){},iconSize: 18 , alignment: Alignment.topCenter,)
              ],
            ),
          ],
        ),
      );

  Widget orderFees(OrderModel orderModel) {



    return ExpandablePanel(
      theme: const ExpandableThemeData(
        tapHeaderToExpand: true,
        iconPadding: EdgeInsets.zero,
        hasIcon: false,
      ),
      collapsed: const SizedBox(),
      header: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.payments),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(orderModel.paymentMethod)
                  ],
                ),
                const Text(
                  "Tap To see Receipt",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
            Container(
              color: Colors.grey.shade300,
              width: 2,
              height: 24,
            ),
            Text(
              "${orderModel.fees} EGP",
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      expanded: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 2)),
          height: 220,
          width: double.infinity,
        ),
      ));
  }
}
