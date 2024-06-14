import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/store_model.dart';
import 'package:shoppizel/Features/home/data/repository/store_repo.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_item.dart';
import 'package:shoppizel/core/widgets/see_all.dart';
import '../../../../../core/widgets/offer_card.dart';
import '../../../data/model/product_model.dart';

class GenderShop extends StatelessWidget {
  final List<ProductModel> collections;
  final StoreRepo repo;
  final StoreModel storeInfo;
  final String? gender ;

  const GenderShop(
      {super.key,
      required this.collections,
      required this.repo,
      required this.storeInfo ,
      this.gender});

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
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: repo.getClothesCategoryOfGender(gender: gender??"Men", model: storeInfo).length ,
              itemBuilder: (context, index) => clothCat(
                  color: storeInfo.color,
                  categories: repo.getClothesCategoryOfGender(gender: collections.first.category!, model: storeInfo)[index]),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: SeeAll(tittle: "Popular"),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              itemCount: repo.getPopularClothes(collections)?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                model: repo.getPopularClothes(collections)?[index],
              ),
            ),
          ),
          offerCard2(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SeeAll(tittle: "Sale"),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              itemCount: repo.getBigSaleProducts(collections).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                model: repo.getBigSaleProducts(collections)[index],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SeeAll(tittle: "Top Rated"),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              itemCount: repo.topRatedProducts(collections).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                model: repo.topRatedProducts(collections)[index],
              ),
            ),
          ),
          offerCard1(),
        ],
      ),
    );
  }

  Widget clothCat({required ClothesCategory categories, required String color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color(int.parse(color)),
            radius: 32,
            child: Center(
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(categories.image),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Text(
            categories.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
