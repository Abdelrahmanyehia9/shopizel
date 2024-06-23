import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.model, required this.color});

  final String color;

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = model.images
            ?.where((item) => item is String)
            .map((item) => item as String)
            .toList() ??
        [];
    List<String> sizes = model.sizes
        ?.where((item) => item is String)
        .map((item) => item as String)
        .toList() ??
        [];
    List<String> colors = model.colors
        ?.where((item) => item is String)
        .map((item) => item as String)
        .toList() ??
        [];

    imageUrls.add(model.imageCover);
    return  SingleChildScrollView(
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
                slideViewportFraction: 1.2,
                isAssets: false,
                autoPlay: false,
                sliderHeight: screenHeight(context)*0.7,
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
                              text: model!.sale != "0"
                                  ? "\$${(double.parse(model!.price!) * (0.99999 - double.parse(model!.sale!) / 100.0)).toStringAsFixed(2)} "
                                  : "\$${model!.price!} ",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: model!.sale != "0"
                                      ? "\$${model?.price}  "
                                      : "",
                                  style:  TextStyle(
                                      color: Colors.grey.shade400,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14),
                                )
                              ]),
                        ) ,
                       rateProduct(rate: model.rate??"0" , count: model.count)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(
                        color: Colors.grey.shade300,
                      ),
                    ) ,
                    sizeChart() ,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: listOfSizes(sizes: sizes ),
                    ),
                    const Text("Select Color" , style: TextStyle(fontWeight: FontWeight.bold ), ) ,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: listOfColors(colors: colors),
                    ) ,
                    productAction(context: context) ,
                    SizedBox(height: 24,) ,

                  ],
                ),
              )
            ],
          ),
        );
  }

  Widget rateProduct({required String rate , required String count }) => Row(
    children: [
      Row(
        children: [
          Icon(Icons.star , color: Colors.yellow.shade700,) ,
          Text(rate , style: const TextStyle(fontSize: 17 , fontWeight: FontWeight.w900),) ,
        ],

      ) ,
const SizedBox(width: 6,) ,
       Text("($count Reviews)" , style: const TextStyle(fontSize: 12 , color: Colors.grey , decoration: TextDecoration.underline , decorationColor: Colors.grey),)

    ],
    );
  Widget sizeChart(){


    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Select Size" , style: TextStyle(fontWeight: FontWeight.bold ), ) ,
        Text("Size Chart" , style: TextStyle(color:  AppConstants.btnColor  , decoration: TextDecoration.underline , decorationColor: AppConstants.btnColor),) ,
       ],
    ) ;



  }
  Widget listOfSizes({required List<String> sizes}){

    return SizedBox(height: 50,
      child: ListView.builder(scrollDirection: Axis.horizontal,

          itemCount: sizes.length , itemBuilder: (context , index) =>
Padding(
  padding: const EdgeInsets.only(right: 8.0),
  child: CircleAvatar(radius: 18.5,backgroundColor: Colors.grey.withOpacity(0.6),
      child: CircleAvatar(backgroundColor: const Color(0xffF3F3F3) , radius: 18, child: Text(sizes[index]  , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 12),),)),
)
      ),
    ) ;


  }
  Widget listOfColors({required List<String> colors}){

    return SizedBox(height: 50,
      child: ListView.builder(scrollDirection: Axis.horizontal,

          itemCount: colors.length , itemBuilder: (context , index) =>
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(radius: 15.5,backgroundColor: Colors.grey.withOpacity(0.6),
                    child: CircleAvatar(backgroundColor: Color(int.parse(colors[index])) , radius: 15,)),
              )
      ),
    ) ;


  }
  Widget productAction({ required BuildContext context})=>Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        height: 60,
        width: screenWidth(context)*0.15,
        decoration: BoxDecoration(border: Border.all(color: Color(int.parse(color)) , width: 2) , borderRadius: BorderRadius.circular(12) ),
        child: Icon(Icons.favorite_border , size: 24, color: Color(int.parse(color),)),
      ) ,


      Container(
        decoration: BoxDecoration(
            color: Color(int.parse(color)),
            borderRadius: BorderRadius.circular(12)
        ),
        width: screenWidth(context) *0.73,
        height: 60,
        child: const Center(child: Text("Add To Cart" , style: TextStyle(color: Colors.white),)),
      ) ,

    ]
  ) ;

}
