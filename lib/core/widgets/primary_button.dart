import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, this.onTap , this.color , this.width});

  final String label;
  final Color? color ;
  final double? width ;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: screenHeight(context) * 0.075,
        width: width?? screenWidth(context),
        decoration:  BoxDecoration(
          color: color ?? AppConstants.appColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Center(
            child: Text(
          label.toUpperCase(),
          style:  TextStyle(
              color: color==null ? Colors.white:AppConstants.appColor , fontWeight: FontWeight.bold, fontSize: 14),
        )),
      ),
    );
  }
}
