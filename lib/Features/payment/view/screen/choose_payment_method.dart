import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppizel/Features/order/view/widget/delivery_time.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';

import '../widget/payment_methods.dart';
import '../widget/select_delivery_time.dart';

class ChoosePaymentMethod extends StatelessWidget {
   ChoosePaymentMethod({super.key});

String selectedTime  = "3 Days";
String selectedPaymentMethod  = "Cash on delivery";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),

      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding (
                padding: EdgeInsets.only(top: 18.0 , right: 4 , left: 4),
                child: Text(
                  "Choose delivery Option",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: AppConstants.appColor ),
                ),

              ),
               SelectDeliveryTime(onSelected: (value){
                 selectedTime = value! ;
               },) ,
              const Padding (
                padding: EdgeInsets.only(top: 18.0 , right: 4 , left: 4),
                child: Text(
                  "Choose payment option",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: AppConstants.appColor ),
                ),

              ),
              const SizedBox(height: 12,) ,
               PaymentMethods(onSelected: (val){
                 selectedPaymentMethod = val! ;
               },) ,
              const Padding (
                padding: EdgeInsets.only(top: 18.0 , right: 4 , left: 4 , bottom: 8),
                child: Text(
                  "Notes on Delivery",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: AppConstants.appColor ),
                ),

              ),
              TextField(

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
contentPadding: const EdgeInsets.symmetric(vertical: 24 , horizontal: 12),
                  hintText: "ex.Don't ring the bell" ,
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(8) ,
                    borderSide: BorderSide.none
                  )
                ),

              )   ,
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: PrimaryButton(label: "Pay" , onTap: (){
                },),
              )
            ],),
        ),
      ),
    );
  }
}


