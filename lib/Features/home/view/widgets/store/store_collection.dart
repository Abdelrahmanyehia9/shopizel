import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/store_model.dart';
import 'package:shoppizel/Features/home/data/repository/store_repo.dart';
import 'package:shoppizel/Features/home/view/widgets/store/constants.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_item.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/see_all.dart';
import '../../../../../core/widgets/offer_card.dart';
import '../../../data/model/product_model.dart';

class StoreCollection extends StatelessWidget {
  final List<ProductModel> collections;
  final StoreModel storeInfo;

  StoreRepo repo = StoreRepo();

  StoreCollection({
    super.key,
    required this.collections,
    required this.storeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          offerCard3(storeInfo.backgroundImg),
          const SizedBox(
            height: 12,
          ),
          const SeeAll(tittle: "Categories"),
          const SizedBox(
            height: 10,
          ),

          ///categories
          SizedBox(
            height: screenHeight(context) * 0.19,
            child: ListView.builder(
              itemCount: repo.getGenderClothCategories(collections).length,
              itemBuilder: (context, index) => clothCat(
                  context: context,
                  color: storeInfo.color,
                  text: repo.getGenderClothCategories(collections)[index]),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: SeeAll(tittle: "Popular"),
          ),

          ///popular clothes
          SizedBox(
            height: 280,
            child: ListView.builder(
              itemCount: repo.getPopularClothes(collections).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                color: storeInfo.color,
                model: repo.getPopularClothes(collections)[index],
              ),
            ),
          ),
          offerCard2(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SeeAll(tittle: "Sale"),
          ),

          ///sale
          SizedBox(
            height: 280,
            child: ListView.builder(
              itemCount: repo.getBigSaleProducts(collections).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                color: storeInfo.color,
                model: repo.getBigSaleProducts(collections)[index],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SeeAll(tittle: "Top Rated"),
          ),

          ///topRated
          SizedBox(
            height: 280,
            child: ListView.builder(
              itemCount: repo.topRatedProducts(collections).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                color: storeInfo.color,
                model: repo.topRatedProducts(collections)[index],
              ),
            ),
          ),
          offerCard1(),
        ],
      ),
    );
  }

  Widget clothCat(
      {required String color,
      required String text,
      required BuildContext context}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(int.parse(color)).withOpacity(0.75),
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                SizedBox(
                  width: screenWidth(context) * 0.22,
                  height: screenHeight(context) * 0.12,
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: GenerateImg.getImg(text),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
