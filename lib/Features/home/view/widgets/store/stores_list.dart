import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../../data/model/store_model.dart';

class StoresList extends StatelessWidget {
  const StoresList({super.key, required this.stores});

  final List<StoreModel> stores;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: stores.length,
          itemBuilder: (context, index) {
            StoreModel item = stores[index];
            return storeItem(
                context: context,
                features: item.features,
                storeName: item.name,
                shippingFees: item.deliveryFees,
                time: item.deliveryTime,
                rating: item.rate,
                urlImage: item.image);
          }),
    );
  }

  Widget storeItem(
      {required BuildContext context,
      required List<dynamic> features,
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(urlImage), fit: BoxFit.cover),
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
                            rating: rating,
                            shipping: shippingFees == "0"
                                ? "free"
                                : "$shippingFees\$",
                            delivery: "$time min"))
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
              fontSize: isBold == null ? 14 : 16,
              fontWeight: isBold != null ? FontWeight.bold : FontWeight.normal),
        )
      ],
    );
  }
}
