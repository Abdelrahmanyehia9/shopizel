import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppizel/Features/shimmer/category_list_Loading.dart';
import 'package:shoppizel/Features/shimmer/clothes_cat_shimmer.dart';
import 'package:shoppizel/Features/shimmer/product_item_loading.dart';
import 'package:shoppizel/Features/shimmer/search_loading.dart';
import 'package:shoppizel/Features/shimmer/see_all_loading.dart';
import 'package:shoppizel/Features/shimmer/store_list_loading.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100, child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12) ,
              color: Colors.white
              ),
              width: screenWidth(context) ,
              height: screenHeight(context)*0.25,
            )),
          ) ,
          SizedBox(height: 11,) ,

          const CategoryListLoading(),

          /// category List (men -women - jewellery - kids)
          const SeeAllLoading(),

          const StoreListLoading()
        ],
      ),
    );
  }
}

class StoreScreenLoading extends StatelessWidget {
  const StoreScreenLoading({super.key});

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
            ///search Loading
            const SearchLoading(),

            /// item product
            SizedBox(
                height: screenHeight(context) * 0.44,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        const ProductItemLoading())),
            const SeeAllLoading(),
            SizedBox(
                height: screenHeight(context) * 0.44,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        const ProductItemLoading())),
            const SeeAllLoading(),
            SizedBox(
                height: screenHeight(context) * 0.44,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        const ProductItemLoading())),
            const SeeAllLoading(),
            SizedBox(
                height: screenHeight(context) * 0.44,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        const ProductItemLoading())),

            // Shimmer.fromColors(child: Container(width: 40, height: 30, color: Colors.white,),       baseColor: Colors.green ,
            //   highlightColor: Colors.grey.shade100,)
          ],
        ),
      ),
    ));
  }
}

class AllProductCatLoading extends StatelessWidget {
  const AllProductCatLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const ClothesCatShimmer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth(context) * 0.78,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: screenHeight(context) * .06,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: screenWidth(context) * 0.15,
                        color: Colors.white,
                        height: screenHeight(context) * 0.06,
                      )),
                ],
              ),
            ),
            StaggeredGridView.countBuilder(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) => Center(
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                        ),
                      ))),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(1, index.isEven ? 2.2 : 1.4),
              mainAxisSpacing: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
