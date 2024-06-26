import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/screen_dimentions.dart';

class ClothesCatShimmer extends StatelessWidget {
  const ClothesCatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),

      child: SizedBox(
        height: screenHeight(context) * 0.2,
        child: ListView.builder(
          itemCount: 6 ,
          itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,highlightColor: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screenHeight(context) *0.15,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12) , color: Colors.white),

              ),
            ),
          ) ,
          scrollDirection: Axis.horizontal,
        ),
      ),
    ) ;
  }
}
