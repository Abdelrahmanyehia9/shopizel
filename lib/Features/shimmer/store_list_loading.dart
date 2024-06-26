import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/screen_dimentions.dart';

class StoreListLoading extends StatelessWidget {
  const StoreListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return           ListView.builder(
      primary: false,
      shrinkWrap: true,
      clipBehavior: Clip.hardEdge,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth(context),
              height: screenHeight(context) * 0.33,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
        );
      },
    ) ;
    ;
  }
}
