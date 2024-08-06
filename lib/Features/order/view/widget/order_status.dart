
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_constants.dart';

class OrderStatue extends StatefulWidget {
  final String orderStatus ;

  const OrderStatue({super.key , required this.orderStatus});

  @override
  State<OrderStatue> createState() => _OrderStatueState();
}

class _OrderStatueState extends State<OrderStatue> {
  late Stream<DocumentSnapshot>stream ;
  int activeStep =  1 ;


  @override
  void initState() {
    if(widget.orderStatus == "Accepted"){
      activeStep = 1 ;
    }else if (widget.orderStatus == "Prepared"){
      activeStep = 2 ;
    }else if (widget.orderStatus == "Onway"){
      activeStep = 3 ;
    }else {
      activeStep = 4  ;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  EasyStepper(
            disableScroll: true,
            padding: EdgeInsets.zero,
            defaultStepBorderType: BorderType.normal,
            enableStepTapping: false,
            activeStepBackgroundColor: AppConstants.secondColor,
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
                    child: const Icon(
                        Icons.check, size: 36, color: Colors.white)
                ),
                customTitle: const Text(
                  'Order confirmed',
                  textAlign: TextAlign.center,
                ),
              ),
              EasyStep(
                customStep: Opacity(
                    opacity: activeStep >= 1 ? 1 : 0,
                    child: const Icon(
                        Icons.add_shopping_cart, size: 36, color: Colors.white)
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
                      child: const Icon(
                          Icons.delivery_dining, size: 36, color: Colors.white)
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
                    child: const Icon(FontAwesomeIcons.circleCheck, size: 36,
                      color: Colors.white,)
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