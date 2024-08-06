import 'package:flutter/material.dart';
import 'package:shoppizel/Features/cart/data/model/cart_model.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../../home/data/model/product_model.dart';

class ProductsInOrder extends StatelessWidget {
  final List<CartModel> products ;
  const ProductsInOrder({super.key  ,required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18 , horizontal: 8),
          height: screenHeight(context)*.17,
          width: screenWidth(context),
          decoration: BoxDecoration(color: AppConstants.appColor ,
              borderRadius: BorderRadius.circular(8)),
          child: ListView.separated(scrollDirection: Axis.horizontal,
              itemBuilder: (context , index) => Container(
                  decoration:  BoxDecoration(
                      image: DecorationImage(image: NetworkImage(products[index].imageUrl)  , fit: BoxFit.cover),
                      color: Colors.white ,  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8) , topRight: Radius.circular(8))),
                  width: screenWidth(context)*.22  ),  separatorBuilder: (context , index) => const SizedBox(width: 12,), itemCount: products.length),
        )

      ],
    );

  }
}
