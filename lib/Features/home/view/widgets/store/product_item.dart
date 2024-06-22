import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/view/screens/product_details.dart';

import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../../core/widgets/rating_stars.dart';

class ProductItem extends StatelessWidget {
  final ProductModel model ;
  final String color ;
  const ProductItem({super.key ,required this.model , required this.color});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          InkWell(
            onTap:(){
             // Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetails(model: model, color: color)));
            showBottomSheet(sheetAnimationStyle: AnimationStyle(duration: const Duration (seconds: 2)),
                context: context, builder: (context)=>ProductDetails(model: model, color:color) );
            } ,
            child: Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(18) ,
              color: Colors.white ,

            ),
              width: 180, height: 280,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center
                ,        children: [
                  Container(
                    decoration:  BoxDecoration(borderRadius: const BorderRadius.only(topRight: Radius.circular(18) , topLeft: Radius.circular(18))
                    ,image: DecorationImage(image: NetworkImage(model?.imageCover ?? "https://cdn.suitdirect.co.uk/upload/siteimages/medium/ar24141mj_021_b.jpg" )  , fit: BoxFit.cover)
                    ),

                    height: 220, width: 180,
                  ) ,
                  const SizedBox(height: 12,) ,
                   Text( model?.name ?? "Cloud Blue Slim Suit" , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 14), overflow: TextOverflow.ellipsis,) ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const RatingStars() ,
                     Text.rich(
                      TextSpan(

                          text: model!.sale != "0" ?"${model?.price}\$  " : ""  , style: const TextStyle(color: Colors.black38 , decoration: TextDecoration.lineThrough , fontSize: 12),
                          children: [
                            TextSpan(text:model!.sale != "0" ? "${(double.parse(model!.price!) * (0.99999-double.parse(model!.sale!)/100.0)).toStringAsFixed(2) }\$" : "${model!.price!}\$" , style: const TextStyle(fontSize: 15 , decoration: TextDecoration.none , color: Colors.red))
                          ]
                      ) ,


                    )



                  ],
                ) ,


                ],
              ),
            ),
          ),
          addToFavourite(),
          Positioned(
            right: 0,
            child: double.parse(model!.sale!) > 20 ?Container(
              padding: const EdgeInsets.all(2),
              color: double.parse(model!.sale!) < 49 ? Colors.green :Colors.red,
              child: Column(
                children: [
                  Text("${model!.sale!}%" , style: const TextStyle(color: Colors.yellow , fontWeight: FontWeight.bold),) ,
                  const Text("Sale" , style: TextStyle(color: Colors.white , fontSize: 12),),
                ],
              ),
            ) : const SizedBox(),
          )
        ],
      ),
    );
  }
  Widget addToFavourite () =>          Container( width: 40, height: 40,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.7) ,borderRadius:  const BorderRadius.only(topLeft: Radius.circular(16) , bottomRight: Radius.circular(16) )),
    child: const Center(child: Icon(Icons.favorite_border_rounded ),),

  ) ;

}
