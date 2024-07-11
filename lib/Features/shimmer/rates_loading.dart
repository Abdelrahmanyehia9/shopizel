import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class RatesLoading extends StatelessWidget {
  const RatesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: ListView.builder(itemBuilder: (context  , index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: screenWidth(context),
          height: screenHeight(context)*.2,
          color: Colors.white,
          child: Row(children: [
            Shimmer.fromColors(
              highlightColor: Colors.grey.shade100,baseColor: Colors.grey.shade300,
              child: Container(
                height: screenHeight(context) * .2,
                width: screenWidth(context) * 0.25,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Shimmer.fromColors(baseColor: Colors.grey.shade300 , highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: screenHeight(context)*0.03,
                        width: screenWidth(context)*.65,
                        color: Colors.white,
                      )
                    ),
                  ),
                  Shimmer.fromColors(baseColor: Colors.grey.shade300 , highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: screenHeight(context)*0.028,
                        width: screenWidth(context)*.65,
                        color: Colors.white,
                      )
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,highlightColor: Colors.grey.shade100,
                    child: const RatingStars(

                      value: 5 ,
                      starColor: Colors.amber,
                      starSize: 12,
                    ),
                  ),
                 Spacer() ,
                  Shimmer.fromColors(baseColor: Colors.grey.shade300 , highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: screenHeight(context)*0.06,
                        width: screenWidth(context)*.65,
                        color: Colors.white,
                      )
                  ),
                  const Spacer(),
                ],
              ),
            ) ,




          ],),
        ),
      )),
    );
  }
}
