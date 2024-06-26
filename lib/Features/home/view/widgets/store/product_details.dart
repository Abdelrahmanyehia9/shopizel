import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:shoppizel/core/function/favourite.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class ProductDetails extends StatefulWidget {
   ProductDetails(
      {super.key,
      required this.model,
      required this.color,
      required this.isFav});

  final String color;
   bool isFav;

  final ProductModel model;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = widget.model.images
            ?.where((item) => item is String)
            .map((item) => item as String)
            .toList() ??
        [];
    List<String> sizes = widget.model.sizes
            ?.where((item) => item is String)
            .map((item) => item as String)
            .toList() ??
        [];
    List<String> colors = widget.model.colors
            ?.where((item) => item is String)
            .map((item) => item as String)
            .toList() ??
        [];

    imageUrls.add(widget.model.imageCover);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FanCarouselImageSlider.sliderType2(
            imagesLink: imageUrls.reversed.toList(),
            indicatorActiveColor: Color(int.parse(widget.color)),
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
                      widget.model.name,
                      style: const TextStyle(fontSize: 18),
                    )),
                Text(
                  widget.model.desc,
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
                          text: widget.model!.sale != "0"
                              ? (double.parse(widget.model.price!) * (0.99999 - double.parse(widget.model.sale!) / 100.0)).toStringAsFixed(2).split(".").first
                              : "${widget.model!.price!} ",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              color: Colors.black),
                          children: [
                            TextSpan(text: ".${(double.parse(widget.model!.price!) * (0.99999 - double.parse(widget.model!.sale!) / 100.0)).toStringAsFixed(2).split(".").last}" , style: const TextStyle(fontSize: 15)) ,
                            const TextSpan(text: " EGP " , style: TextStyle(fontSize: 14)) ,
                            TextSpan(
                              text: widget.model!.sale != "0"
                                  ? "${widget.model?.price}EGP "
                                  : "",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey,
                                  fontSize: 14),
                            )
                          ]),
                    ),
                    rateProduct(rate: widget.model.rate ?? "0", count: widget.model.count)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    color: Colors.grey.shade300,
                  ),
                ),
                sizeChart(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: listOfSizes(sizes: sizes),
                ),
                const Text(
                  "Select Color",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: listOfColors(colors: colors),
                ),
                productAction(context: context, isFav: widget.isFav , onTap: (){

                  Favourite.favHandler(widget.isFav,  widget.model);

                  setState(() {

widget.isFav = !widget.isFav ;

                  });

                }),
                const SizedBox(
                  height: 24,
                ),
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
                rate,
                style:
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
          )
        ],
      );

  Widget sizeChart() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Size",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "Size Chart",
          style: TextStyle(
              color: AppConstants.appColor,
              decoration: TextDecoration.underline,
              decorationColor: AppConstants.appColor),
        ),
      ],
    );
  }

  Widget listOfSizes({required List<String> sizes}) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sizes.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                    radius: 18.5,
                    backgroundColor: Colors.grey.withOpacity(0.6),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xffF3F3F3),
                      radius: 18,
                      child: Text(
                        sizes[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    )),
              )),
    );
  }

  Widget listOfColors({required List<String> colors}) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                    radius: 15.5,
                    backgroundColor: Colors.grey.withOpacity(0.6),
                    child: CircleAvatar(
                      backgroundColor: Color(int.parse(colors[index])),
                      radius: 15,
                    )),
              )),
    );
  }

  Widget productAction({required BuildContext context, required bool isFav , GestureTapCallback? onTap}) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 60,
          width: screenWidth(context) * 0.15,
          decoration: BoxDecoration(
              color:
                 Color(int.parse(widget.color))  ,
              borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: onTap,
              child: Icon(
            Icons.favorite,
            size: 24,
            color: isFav == false ? Colors.white : Colors.red,
          )),
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(int.parse(widget.color)),
              borderRadius: BorderRadius.circular(12)),
          width: screenWidth(context) * 0.73,
          height: 60,
          child: const Center(
              child: Text(
            "Add To Cart",
            style: TextStyle(color: Colors.white),
          )),
        ),
      ]);
}
