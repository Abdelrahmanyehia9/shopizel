import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/home/view/screens/store_screen.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/app_router.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../../data/model/store_model.dart';

class StoresList extends StatelessWidget {
  const StoresList({super.key, required this.stores , required this.allProducts});
  final List<StoreModel> stores;
  final List<ProductModel> allProducts ;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      clipBehavior: Clip.hardEdge,
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return storeItem(
              context: context,
            storeModel:  stores[index] ,
          products: allProducts);
        });
  }

  Widget storeItem(
      {required BuildContext context,
      required StoreModel storeModel ,
      required List<ProductModel> products}) {
    List<String> features = []  ;
     for (int i = 0 ; i < storeModel.shopCategory.length ; i ++ ){
       features.add(storeModel.shopCategory[i].name) ;
     }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0 , horizontal: 4),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) {
          List<ProductModel> collections =   HomeRepo().getStoreProducts(allProducts, storeModel.name) ;

           return StoreScreen(storeModel : storeModel , storeCollection: collections,  ) ;
          }));



        },
        child: Container(
            width: screenWidth(context),
            height: screenHeight(context) * 0.33,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth(context),
                  height: screenHeight(context) * 0.185,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(storeModel.image), fit: BoxFit.cover),
                    color: Colors.black,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16)),
                    //image: DecorationImage(image: NetworkImage(""))
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        storeModel.name,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.03,
                        child: ListView.builder(
                            clipBehavior: Clip.none,
                            itemCount: features.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (index + 1 == features.length) {
                                return Text(
                                  "${features[index]}  ",
                                  style:
                                      const TextStyle(color: Color(0xffA0A5BA)),
                                );
                              } else {
                                return Text(
                                  "${features[index]} - ",
                                  style:
                                      const TextStyle(color: Color(0xffA0A5BA)),
                                );
                              }
                            }),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                          width: screenWidth(context) * 0.65,
                          child: ratings(
                              rating: storeModel.rate,
                              shipping: storeModel.deliveryFees == "0"
                                  ? "free"
                                  : "${storeModel.deliveryFees}\$",
                              delivery: "${storeModel.deliveryTime} min"))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget ratings(
      {required String rating, required String shipping, required delivery}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customTile(
            icon: Icons.star_border_outlined, text: rating, isBold: true),
        customTile(icon: Icons.local_shipping_outlined, text: shipping),
        customTile(icon: Icons.access_time, text: delivery)
      ],
    );
  }

  Widget customTile(
      {required String text, required IconData icon, bool? isBold}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppConstants.btnColor,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: isBold == null ? 14 : 16,
              fontWeight: isBold != null ? FontWeight.bold : FontWeight.normal),
        )
      ],
    );
  }
}
