import 'package:easy_stepper/easy_stepper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../data/order_model.dart';

class OrderTracking extends StatelessWidget {
  const OrderTracking({super.key });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(title: const Text("Track your Order"),
      actions: [

        TextButton(onPressed: (){}, style: TextButton.styleFrom(foregroundColor: Colors.white),child: const Text("Help") ,) ,

      ],),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0 ,horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
SizedBox(

  height: screenHeight(context)*0.7,
  child: SingleChildScrollView(
    primary: false,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      TimeOfOrder() ,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text("Order Statue" , style: TextStyle(fontWeight: FontWeight.bold , color: AppConstants.secondColor),),
      ) ,
      OrderStatue() ,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text("5 Products in your Order" ,style: TextStyle(color: Colors.grey), ),
      ) ,
      ProductsInOrder() ,
      SizedBox(height: 16,) ,
      orderFees() ,
      SizedBox(height: 12,) ,
    ],),
  ),
) ,

              ElevatedButton(

                onPressed: (){} , child: const Text("Cancel  Order" , ) ,

              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  disabledBackgroundColor: Colors.grey.withOpacity(0.4),
                  disabledForegroundColor: Colors.grey.shade600,

                  fixedSize: Size(screenWidth(context), 50)),


              )




          ],),
        ),
      ),




    );
  }



  Widget TimeOfOrder()=>Container(
    width: double.infinity,
    decoration: BoxDecoration(color: Colors.white ,
    borderRadius: BorderRadius.circular(8) ,
    boxShadow: AppConstants.shadow

    ),
    padding: EdgeInsets.all(16),
    child: Column(children: [
      Text("Mon, 19 Augest 2024"  , style: TextStyle(color: AppConstants.appColor  , fontSize: 18),) ,
      Text("Arrive In : 3 hours | before 5:00 AM" , style: TextStyle(color: Colors.grey  ,fontSize: 12),) ,
      Text("Order NO : #fhgnmfjngfjggfjn") ,

    ],),
  ) ;
  Widget orderFees()=>ExpandablePanel(
      theme: const ExpandableThemeData(
        tapHeaderToExpand: true,
        iconPadding: EdgeInsets.zero,
        hasIcon: false,
      ),
      collapsed: const SizedBox(),
      header: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300 ,width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.payments) ,
                    SizedBox(width: 4,) ,
                    Text("Cash On Delivery")
                  ],
                ),
                Text("Tap To see Recipt" , style: TextStyle(fontSize: 12 , color: Colors.grey),)
              ],
            ) ,
            Container(
              color: Colors.grey.shade300,
              width: 2,
              height: 24,

            ) ,
            Column(
              children: [
                Text(
                  "154 EGP",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                    decoration: BoxDecoration(color: Colors.red,
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(4),
                    child: Text("74 EGP Saved"  , style: TextStyle(color: Colors.white ,fontSize: 8),))
              ],
            ),
          ],
        ),
      ),
      expanded:
         Padding(
           padding: const EdgeInsets.only(top: 4.0),
           child: Container(decoration: BoxDecoration(
             border: Border.all(color: Colors.grey.shade300 , width: 2)
           ), height: 220, width: double.infinity,),
         )


  );

}
class OrderStatue extends StatefulWidget {

  const OrderStatue({super.key});

  @override
  State<OrderStatue> createState() => _OrderStatueState();
}

class _OrderStatueState extends State<OrderStatue> {
  int activeStep = 3;
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      disableScroll: true,

      padding: EdgeInsets.zero,
        defaultStepBorderType: BorderType.normal,
      enableStepTapping: false,
      activeStepBackgroundColor: AppConstants.secondColor ,
         titlesAreLargerThanSteps: true,
      activeStep: activeStep,
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 12,
      borderThickness: 5,
      stepRadius: 28,

      activeStepBorderColor: Colors.transparent,
      finishedStepBorderColor: Colors.transparent,
      finishedStepBackgroundColor: AppConstants.appColor,
      activeStepIconColor: AppConstants.appColor,
      showLoadingAnimation: true,
      steps: [
        EasyStep(
          customStep: Opacity(
            opacity: activeStep >= 0 ? 1 : 0,
              child: Icon(Icons.check , size: 36 , color: Colors.white)
          ),
          customTitle: const Text(
            'Order confirmed',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: Opacity(
            opacity: activeStep >= 1 ? 1 : 0,
              child: Icon(Icons.add_shopping_cart , size: 36 , color: Colors.white)
          ),
          customTitle: const Text(
            'Preparing order',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 2 ? 1 : 0,
              child: Icon(Icons.delivery_dining , size: 36 , color: Colors.white)
            ),
          ),
          customTitle: const Text(
            'Order On way',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: Opacity(
            opacity: activeStep >= 3 ? 1 : 0,
              child: const Icon(FontAwesomeIcons.circleCheck , size: 36 , color: Colors.white,)
          ),
          customTitle: const Text(
            'Order delivered',
            textAlign: TextAlign.center,
          ),
        ),
      ],
      onStepReached: (index) => setState(() => activeStep = index),
    );
  }
}

class ProductsInOrder extends StatelessWidget {
  const ProductsInOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 18 , horizontal: 8),
        height: screenHeight(context)*.17,
        width: screenWidth(context),
        decoration: BoxDecoration(color: AppConstants.appColor ,
        borderRadius: BorderRadius.circular(8)),
        child: ListView.separated(scrollDirection: Axis.horizontal,
            itemBuilder: (context , index) => Container(
              decoration: BoxDecoration(color: Colors.white ,  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8) , topRight: Radius.circular(8))),
              width: screenWidth(context)*.22  ),  separatorBuilder: (context , index) => SizedBox(width: 12,), itemCount: 15),
      )

      ],
    );

  }
}





