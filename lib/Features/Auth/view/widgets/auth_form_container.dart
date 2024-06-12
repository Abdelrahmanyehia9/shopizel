import 'package:flutter/material.dart';

import '../../../../core/utils/screen_dimentions.dart';

class AuthFormContainer extends StatelessWidget {
  const AuthFormContainer({super.key, required this.form});

  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: screenHeight(context) * 0.65,
        width: screenWidth(context),
        child: form,
      ),
    );
    ();
  }
}
