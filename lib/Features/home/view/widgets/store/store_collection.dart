import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/store_model.dart';
import 'package:shoppizel/Features/home/data/repository/store_repo.dart';
import 'package:shoppizel/Features/home/view/screens/all_product_view.dart';
import 'package:shoppizel/Features/home/view/widgets/store/clothes_cat.dart';
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
         storeInfo.offer !=null ?  offerCard3(storeInfo.offer) :const SizedBox(),

          const SizedBox(
            height: 12,
          ),

          ///categories
          const SeeAll(tittle: "Categories"),
          SizedBox(
            height: screenHeight(context) * 0.19,
            child: ListView.builder(
              itemCount: repo.getGenderClothCategories(collections).length > 7?(repo.getGenderClothCategories(collections).length/2).round():repo.getGenderClothCategories(collections).length,
              itemBuilder: (context, index) => ClothesCat(
                  color: storeInfo.color,
                  text: repo.getGenderClothCategories(collections)[index]),
              scrollDirection: Axis.horizontal,
            ),
          ),

          ///popular
          SeeAll(
            tittle: "Popular",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AllProductView(
                          categories:
                              repo.getGenderClothCategories(collections),
                          color: storeInfo.color,
                          collection: repo.getPopularClothes(collections))));
            },
          ),
          SizedBox(
            height: screenHeight(context) * 0.38,
            child: ListView.builder(
              itemCount: collections.length>  7 ?(repo.getPopularClothes(collections).length/3).round(): collections.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                color: storeInfo.color,
                model: repo.getPopularClothes(collections)[index],
              ),
            ),
          ),

          ///special offer
          storeInfo.specialOffer != null ?offerCard2(offer: storeInfo.specialOffer??"Big Sale See our stores"):const SizedBox(),

          ///sale
          SeeAll(
            tittle: "Sale",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllProductView(
                    categories: repo.getGenderClothCategories(collections),
                    color: storeInfo.color,
                    collection: repo.getBigSaleProducts(collections)
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: screenHeight(context) * 0.38,
            child: ListView.builder(
              itemCount:  collections.length>7?(repo.getBigSaleProducts(collections).length/3).round():collections.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                color: storeInfo.color,
                model: repo.getBigSaleProducts(collections)[index],
              ),
            ),
          ),

          ///newest
          SeeAll(
            tittle: "Newest",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllProductView(
                    categories: repo.getGenderClothCategories(collections),
                    color: storeInfo.color,
                    collection: repo.getNewestClothes(collections),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: screenHeight(context) * 0.38,
            child: ListView.builder(
              itemCount: (repo.getNewestClothes(collections).length/3).round(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                color: storeInfo.color,
                model: repo.getNewestClothes(collections)[index],
              ),
            ),
          ),
          ///top rated
          SeeAll(
            tittle: "Top Rated",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AllProductView(
                          categories:
                              repo.getGenderClothCategories(collections),
                          color: storeInfo.color,
                          collection: repo.topRatedProducts(collections))));
            },
          ),
          SizedBox(
            height: screenHeight(context) * 0.38,
            child: ListView.builder(
              itemCount: collections.length>7? (repo.topRatedProducts(collections).length/3).round():collections.length,
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
}
