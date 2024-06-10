import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class SnackBars {


  static  void CustomSnackBar({required BuildContext context ,required String desc ,required String tittle ,required AnimatedSnackBarType type })=> AnimatedSnackBar.rectangle(
    tittle,
    desc,
    brightness: Brightness.dark,
    type: type,
    duration: const Duration(seconds: 3),
    mobilePositionSettings: const MobilePositionSettings(
      topOnAppearance: 0,
    ),
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  ).show(context);









}