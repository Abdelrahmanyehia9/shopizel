import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/screen_dimentions.dart';

class SavedAddressesLoading extends StatelessWidget {
  const SavedAddressesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white ,
          width: screenWidth(context),
          height: screenHeight(context)*0.375,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Shimmer.fromColors(baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100, child: Container(
                width: screenWidth(context),
                height: screenHeight(context) * 0.2,
                color: Colors.white,

              ))  ,
              Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Shimmer.fromColors(baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100, child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    width: screenWidth(context) *0.2,
                    height: screenHeight(context)*0.025,))
              ),
              Shimmer.fromColors(baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100, child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                ),
                width: screenWidth(context) *0.9,
                height: screenHeight(context)*0.035,)),
              Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Shimmer.fromColors(baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100, child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    width: screenWidth(context) *0.75,
                    height: screenHeight(context)*0.05,))
              ),

            ],
          ),
        ),
        SizedBox(height: 12,) ,
        Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              color: Colors.white ,
              width: screenWidth(context),
              height: screenHeight(context)*0.375,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Shimmer.fromColors(baseColor: Colors.grey.shade700, highlightColor: Colors.grey, child: Container(
                    width: screenWidth(context),
                    height: screenHeight(context) * 0.2,
                    color: Colors.white,

                  ))  ,
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Shimmer.fromColors(baseColor: Colors.grey.shade700, highlightColor: Colors.grey, child: Container(color: Colors.white,
                        width: screenWidth(context) *0.6,
                        height: screenHeight(context)*0.15,))
                  ),
                ],
              ),
            )),


      ],
    );
  }
}
