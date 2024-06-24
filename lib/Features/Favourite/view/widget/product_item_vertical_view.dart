import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_details.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/rating_stars.dart';

import '../../../home/data/model/product_model.dart';

class ProductItemVerticalView extends StatelessWidget {
  final ProductModel favourite ;
  const ProductItemVerticalView({super.key , required this.favourite});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        showBottomSheet(context: context, builder: (_)=> ProductDetails(model: favourite, color: AppConstants.btnColor.value.toString() , isFav: true,)  ,sheetAnimationStyle: AnimationStyle(reverseCurve: Curves.bounceOut , duration: Duration(seconds: 3)) ) ;
      },
      child: Padding(
        padding:  EdgeInsets.all(screenWidth(context)*.03),
        child: SizedBox(
          width: double.infinity,
          height: screenHeight(context) *.33,
      child: Stack(
        alignment: AlignmentDirectional.centerStart
        ,
        children: [
        Container(

      decoration:  BoxDecoration(
          color: Colors.white,


      ),
      height: screenHeight(context)*.3,
      padding: const EdgeInsets.all(8),
      width: screenWidth(context)*0.55 ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(favourite.name , style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),) ,
              const SizedBox(height: 4,) ,
              SizedBox(width: screenWidth(context)*0.45,
                  child: Text(favourite.desc , style: const TextStyle(color: Colors.grey , fontSize: 11),overflow: TextOverflow.ellipsis,maxLines: 5,)) ,

              const SizedBox(height: 8,) ,

              Row(
                children: [


                  const RatingStars() ,
                  Text("(${favourite.count} reviews)" , style: const TextStyle(color: Colors.grey , fontSize: 10 ,decoration: TextDecoration.underline , decorationColor: Colors.grey , fontWeight: FontWeight.bold),)



                ],
              ) ,
            ],
          ) ,


          Text.rich(
            TextSpan(
                text:favourite.sale != "0" ? "${(double.parse(favourite.price!) * (0.99999-double.parse(favourite.sale!)/100.0)).toStringAsFixed(2) }EGP " : "${favourite.price!}EGP " , style: const TextStyle(fontSize: 14 , decoration: TextDecoration.none , color: AppConstants.btnColor, fontWeight: FontWeight.bold,),
                children: [
                  TextSpan(text: favourite.sale != "0" ?"${favourite.price}EGP " : ""  , style: const TextStyle(color: Colors.grey , decoration: TextDecoration.lineThrough , fontSize: 10 , decorationColor: Colors.grey),)

                ]
            ) ,


          )






        ],),
        ),

        Positioned(
      right: 0,
      child: Container(
        width: screenWidth(context)*.42,

        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(favourite.imageCover) , fit: BoxFit.cover),
            boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(4, 0), // changes position of shadow
            ) ],
            borderRadius: BorderRadius.circular(12)

        ),
        height: screenHeight(context)*.33,
      ),
        ) ,


      ],),
        ),
      ),
    );
  }
}
