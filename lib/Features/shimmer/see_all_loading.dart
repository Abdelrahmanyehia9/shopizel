import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/screen_dimentions.dart';

class SeeAllLoading extends StatelessWidget {
  const SeeAllLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return                 Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: screenWidth(context)  ,
            height: screenHeight(context) * .06,
            color: Colors.white,
          )),
    )
    ;
  }
}
