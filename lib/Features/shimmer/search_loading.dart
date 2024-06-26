import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/screen_dimentions.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return                 Padding(
      padding:  const EdgeInsets.symmetric(vertical: 4.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: screenWidth(context)  ,
            height: screenHeight(context) * .075,
            color: Colors.white,
          )),
    ) ;
    ;
  }
}
