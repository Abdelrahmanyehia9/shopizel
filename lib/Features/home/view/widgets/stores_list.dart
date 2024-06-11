import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class StoresList extends StatelessWidget {
  const StoresList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          storeItem(context: context, features: ["jeans , shirts , jackets"], storeName: "Lc waikiki", shippingFees: "0", time: "20", rating: "3.7", urlImage: "https://eg.jumia.is/cms/5-22/LC_Waikiki_-_730x292.jpg")
,          storeItem(context: context, features: ["mens , woman , kids" , "baby"], storeName: "Zara", shippingFees: "40", time: "35", rating: "2.7", urlImage: "https://logomakerr.ai/blog/wp-content/uploads/2022/08/2019-to-Present-Zara-logo-design-1024x538.jpg")




        ],
      ),
    );
  }

  Widget storeItem(
      {required BuildContext context,
      required List<String> features,
      required String storeName,
      required String shippingFees,
      required String time,
      required String rating,
      required String urlImage}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                decoration:  BoxDecoration(
                  image: DecorationImage(image: NetworkImage(urlImage) , fit: BoxFit.cover),
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
                      storeName,
                      style: const TextStyle(
                          fontSize: 20, fontFamily: AppConstants.fontFamily),
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
                                style: const TextStyle(
                                    fontFamily: AppConstants.fontFamily,
                                    color: Color(0xffA0A5BA)),
                              );
                            } else {
                              return Text(
                                "${features[index]} - ",
                                style: const TextStyle(
                                    fontFamily: AppConstants.fontFamily,
                                    color: Color(0xffA0A5BA)),
                              );
                            }
                          }),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                        width: screenWidth(context) * 0.65,
                        child: ratings(
                            rating: rating, shipping: shippingFees == "0" ? "free" : "${shippingFees}\$", delivery: "$time min"))
                  ],
                ),
              )
            ],
          )),
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
              fontFamily: AppConstants.fontFamily,
              fontSize: isBold == null ? 14 : 16,
              fontWeight: isBold != null ? FontWeight.bold : FontWeight.normal),
        )
      ],
    );
  }
}
