import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class PromoCodesLoading extends StatelessWidget {
  const PromoCodesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white ,
                      borderRadius: BorderRadius.circular(8)),
                  width: double.infinity,
                  height: screenHeight(context) * .25,
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.white,
                              height: screenHeight(context) * 0.25,
                              width: screenWidth(context) * 0.4,
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  height: screenHeight(context) * 0.04,
                                  width: screenWidth(context) * 0.45,
                                ),
                              )),
                          Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                height: screenHeight(context) * 0.03,
                                width: screenWidth(context) * 0.3,
                              )),
                          Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  height: screenHeight(context) * 0.042,
                                  width: screenWidth(context) * 0.45,
                                ),
                              )),
                          const Spacer() ,
                          Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                height: screenHeight(context) * 0.065,
                                width: screenWidth(context) * 0.47,
                              )),
                          SizedBox(height: screenHeight(context)*0.01,)

                        ],
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
