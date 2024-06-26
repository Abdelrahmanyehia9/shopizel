import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, this.onTap});

  final String label;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: screenHeight(context) * 0.075,
        width: screenWidth(context),
        decoration: const BoxDecoration(
          color: AppConstants.appColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Center(
            child: Text(
          label.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        )),
      ),
    );
  }
}
