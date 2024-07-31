import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppizel/Features/home/view/screens/home_screen.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';

class OrderConfirmed extends StatelessWidget {
  final String orderNo ;
  const OrderConfirmed({super.key , required this.orderNo});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffFCFEFC) ,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Spacer() ,
          Center(
            child: SizedBox(
        height: screenHeight(context)*.25,
              child: Image.asset("assets/images/derp.gif" ,fit: BoxFit.cover),
            ),
          ) ,
            SizedBox(height: screenHeight(context)*.02,) ,
            const Text("Order Confirmed !" , style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold),) ,
            const SizedBox(height: 12,) ,
            const Text("Check dashboard to check order status" , textAlign: TextAlign.center , style: TextStyle(fontSize: 16 , color: Colors.grey),) ,
             Text("Your Order NO : ${orderNo}" , textAlign:TextAlign.center, style: TextStyle(fontSize: 14 , color: Colors.grey.shade600),) ,
            const SizedBox(height: 18,) ,
             PrimaryButton(label: "done" , onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>const HomeScreen()) , (route)=>false) ;
            },) ,


        const Spacer()



          ],),
      ),
    );
  }
}
