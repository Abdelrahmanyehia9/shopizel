import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/screen_dimentions.dart';

class CategoryListLoading extends StatelessWidget {
  const CategoryListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return           Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
      child: SizedBox(
        height: screenHeight(context) * 0.18,
        child: ListView.builder(
          itemCount: 4,
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.white,
                  width: screenWidth(context) * 0.32,
                ),
              ),
            ),
          ),
        ),
      ),
    ) ;
    ;
  }
}
