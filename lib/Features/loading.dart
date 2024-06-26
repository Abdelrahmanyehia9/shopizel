import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import '../core/widgets/see_all.dart';

class HomeLoadingShimmer extends StatelessWidget {
  const HomeLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// space
          SizedBox(
            height: screenHeight(context) * 0.035,
          ),

          ///search product
          /// offer of the week in database
          const SeeAll(
            tittle: "All Category",
          ),

          /// category List (men -women - jewellery - kids)
          Padding(
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
          ),
          const SeeAll(
            tittle: "Open Stores",
          ),

          ListView.builder(
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
          ),
        ],
      ),
    );
  }
}

class StoreScreenLoading extends StatefulWidget {
  const StoreScreenLoading({super.key});

  @override
  State<StoreScreenLoading> createState() => _StoreScreenLoadingState();
}

class _StoreScreenLoadingState extends State<StoreScreenLoading> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: screenWidth(context)  ,
                    height: screenHeight(context) * .06,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
                height: screenHeight(context) * 0.44,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Column(
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
                        ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: screenWidth(context)  ,
                            height: screenHeight(context) * .06,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                        height: screenHeight(context) * 0.44,
                        child: ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Column(
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
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: screenWidth(context)  ,
                            height: screenHeight(context) * .06,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                        height: screenHeight(context) * 0.44,
                        child: ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Column(
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
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: screenWidth(context)  ,
                            height: screenHeight(context) * .06,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                        height: screenHeight(context) * 0.44,
                        child: ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Column(
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
                            ))),
            
            // Shimmer.fromColors(child: Container(width: 40, height: 30, color: Colors.white,),       baseColor: Colors.green ,
            //   highlightColor: Colors.grey.shade100,)
                  ],
                ),
          ),
        ));
  }
}
