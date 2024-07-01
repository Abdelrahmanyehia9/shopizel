import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/store_cubit.dart';
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
import '../../screens/product_spacific_cat.dart';

class StoreCollection extends StatefulWidget {
  final List<ProductModel> collections;
  final StoreModel storeInfo;


  StoreCollection({
    super.key,
    required this.collections,
    required this.storeInfo,
  });

  @override
  State<StoreCollection> createState() => _StoreCollectionState();
}

class _StoreCollectionState extends State<StoreCollection> {
  StoreRepo repo = StoreRepo();

  @override
  Widget build(BuildContext context) {
    List<String> categories = repo.getGenderClothCategories(widget.collections).toSet().toList() ;
    return RefreshIndicator(
      onRefresh: ()async{
        BlocProvider.of<StoreCubit>(context).getCollection(storeName: widget.storeInfo.name) ;
      },
      child: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: ()async{

          },
          child: Column(
            children: [

              const SizedBox(
                height: 12,
              ),

              ///categories
              const SeeAll(tittle: "Categories"),
              SizedBox(
                height: screenHeight(context) * 0.19,
                child: ListView.builder(
                  itemCount: categories.length > 7?(categories.length/2).round():categories.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductsSpecificCat(collection: StoreRepo().getTypeOfClothes(widget.collections, categories[index]), color: widget.storeInfo.color) ) );

                    },
                    child: ClothesCat(

                        color: widget.storeInfo.color,
                        text: categories[index]),
                  ),
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
                                  repo.getGenderClothCategories(widget.collections),
                              color: widget.storeInfo.color,
                              collection: repo.getPopularClothes(widget.collections))));
                },
              ),
              SizedBox(
                height: screenHeight(context) * 0.38,
                child: ListView.builder(
                  itemCount: widget.collections.length>  7 ?(repo.getPopularClothes(widget.collections).length/3).round(): widget.collections.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ProductItem(
                    color: widget.storeInfo.color,
                    model: repo.getPopularClothes(widget.collections)[index],
                  ),
                ),
              ),

              ///special offer
              widget.storeInfo.specialOffer != null ?offerCard2(offer: widget.storeInfo.specialOffer??"Big Sale See our stores"):const SizedBox(),

              ///sale
              SeeAll(
                tittle: "Sale",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllProductView(
                        categories: repo.getGenderClothCategories(widget.collections),
                        color: widget.storeInfo.color,
                        collection: repo.getBigSaleProducts(widget.collections)
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: screenHeight(context) * 0.38,
                child: ListView.builder(
                  itemCount:  widget.collections.length>7?(repo.getBigSaleProducts(widget.collections).length/3).round():widget.collections.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ProductItem(
                    color: widget.storeInfo.color,
                    model: repo.getBigSaleProducts(widget.collections)[index],
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
                        categories: repo.getGenderClothCategories(widget.collections),
                        color: widget.storeInfo.color,
                        collection: repo.getNewestClothes(widget.collections),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: screenHeight(context) * 0.38,
                child: ListView.builder(
                  itemCount: widget.collections.length>7?(repo.getNewestClothes(widget.collections).length/3).round():widget.collections.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ProductItem(
                    color: widget.storeInfo.color,
                    model: repo.getNewestClothes(widget.collections)[index],
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
                                  repo.getGenderClothCategories(widget.collections),
                              color: widget.storeInfo.color,
                              collection: repo.topRatedProducts(widget.collections))));
                },
              ),
              SizedBox(
                height: screenHeight(context) * 0.38,
                child: ListView.builder(
                  itemCount: widget.collections.length>7? (repo.topRatedProducts(widget.collections).length/3).round():widget.collections.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ProductItem(
                    color: widget.storeInfo.color,
                    model: repo.topRatedProducts(widget.collections)[index],
                  ),
                ),
              ),
              offerCard1(),
            ],
          ),
        ),
      ),
    );
  }
}
