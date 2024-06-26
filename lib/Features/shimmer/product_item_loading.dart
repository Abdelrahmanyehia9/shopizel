import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/screen_dimentions.dart';

class ProductItemLoading extends StatelessWidget {
  const ProductItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                width: screenWidth(context) * 0.6,
                height: screenHeight(context) * 0.3,
              ),
            )),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: screenWidth(context) * 0.6,
                height: screenHeight(context) * .045,
                color: Colors.white,
              )),
        ),
        SizedBox(
          height: screenHeight(context) * 0.01,
        ),
        Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(1),
                  child: Container(
                    width: screenWidth(context) * 0.365,
                    height: screenHeight(context) * .025,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              width: screenWidth(context) * 0.035,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(1),
                  child: Container(
                    width: screenWidth(context) * 0.2,
                    height: screenHeight(context) * .025,
                    color: Colors.white,
                  )),
            )
          ],
        )
      ],
    );
  }
}
