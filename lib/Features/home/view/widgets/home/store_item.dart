import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../data/model/store_model.dart';
import '../../screens/store_screen.dart';

class StoreItem extends StatelessWidget {
  final  StoreModel storeModel  ;
  final List<String> features ;
  const StoreItem({super.key , required this.storeModel , required this.features});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
      child: InkWell(

        onTap: () {

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => StoreScreen(
                    storeModel: storeModel,
                  )));
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
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: storeModel.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
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
                          child: storeRatings(
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
  Widget storeRatings(
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

  /// icon with text
  Widget customTile(
      {required String text, required IconData icon, bool? isBold}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppConstants.appColor,
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
