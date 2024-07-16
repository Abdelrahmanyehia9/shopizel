import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:shoppizel/Features/rate/view/widget/product_rate.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'choose_size_and_color.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails(
      {super.key,
      required this.model,
      required this.color,
      required this.isFav});

  final String color;
 final bool isFav;
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = model.images
            ?.where((item) => item is String)
            .map((item) => item as String)
            .toList() ??
        [];

    imageUrls.add(model.imageCover);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FanCarouselImageSlider.sliderType2(
            imagesLink: imageUrls.reversed.toList(),
            indicatorActiveColor: Color(int.parse(color)),
            imageRadius: 0,
            initalPageIndex: 0,
            slideViewportFraction: 1,
            isAssets: false,
            autoPlay: false,
            sliderHeight: screenHeight(context) * 0.6,
            sideItemsShadow: const [],
            currentItemShadow: const [],
            expandedImageFitMode: BoxFit.cover,
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: screenWidth(context) * 0.75,
                    child: Text(
                      model.name,
                      style: const TextStyle(fontSize: 18),
                    )),
                Text(
                  model.desc,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: model.sale != "0"
                              ? (double.parse(model.price!) *
                                      (0.99999 -
                                          double.parse(model.sale!) / 100.0))
                                  .toStringAsFixed(2)
                                  .split(".")
                                  .first
                              : "${model.price!} ",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text:
                                    ".${(double.parse(model.price!) * (0.99999 - double.parse(model.sale!) / 100.0)).toStringAsFixed(2).split(".").last}",
                                style: const TextStyle(fontSize: 15)),
                            const TextSpan(
                                text: " EGP ", style: TextStyle(fontSize: 14)),
                            TextSpan(
                              text: model.sale != "0"
                                  ? "${model.price}EGP "
                                  : "",
                              style: const TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  fontSize: 12),
                            )
                          ]),
                    ),

                  ],
                ),
                ProductRate(model: model,) ,

                /// to make order
                ChoseSizeAndColor(color: color, model: model) ,

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rateProduct({required String rate, required String count}) => Row(
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow.shade700,
              ),
              Text(
                rate, style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "($count Reviews)",
            style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey),
          ),
        ],
      );
}
