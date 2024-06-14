import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';

import '../../../../../core/widgets/rating_stars.dart';

class ProductItem extends StatelessWidget {
  final ProductModel? model ;
  const ProductItem({super.key , this.model});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(18) ,
            color: Colors.white ,

          ),
            width: 180, height: 280,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center
              ,        children: [
                Container(
                  decoration:  BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(18) , topLeft: Radius.circular(18))
                  ,image: DecorationImage(image: NetworkImage(model?.imageCover ?? "https://cdn.suitdirect.co.uk/upload/siteimages/medium/ar24141mj_021_b.jpg" )  , fit: BoxFit.fill)
                  ),

                  height: 220, width: 180,
                ) ,
                const SizedBox(height: 12,) ,
                 Text( model?.name ?? "Cloud Blue Slim Suit" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14), overflow: TextOverflow.ellipsis,) ,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RatingStars() ,
                   Text.rich(
                    TextSpan(

                        text: model!.sale != "0" ?"${model?.price}\$  " : ""  , style: TextStyle(color: Colors.black38 , decoration: TextDecoration.lineThrough , fontSize: 12),
                        children: [
                          TextSpan(text:model!.sale != "0" ? "${(double.parse(model!.price!) * (1-int.parse(model!.sale!)/100.0)).toStringAsFixed(2)  }\$" : "${model!.price!}\$" , style: TextStyle(fontSize: 15 , decoration: TextDecoration.none , color: Colors.red))
                        ]
                    ) ,


                  )



                ],
              ) ,


              ],
            ),
          ),
          addToFavourite()
        ],
      ),
    );
  }
  Widget addToFavourite () =>          Container( width: 40, height: 40,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.7) ,borderRadius:  const BorderRadius.only(topLeft: Radius.circular(16) , bottomRight: Radius.circular(16) )),
    child: const Center(child: Icon(Icons.favorite_border_rounded ),),

  ) ;

}
