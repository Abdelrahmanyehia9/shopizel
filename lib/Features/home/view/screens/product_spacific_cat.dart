import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../data/model/product_model.dart';
import '../widgets/home/search_textfield.dart';
import '../widgets/store/product_item.dart';

class ProductsSpecificCat extends StatelessWidget {
  final List<ProductModel> collection ;
  final String color ;
  const ProductsSpecificCat({super.key , required this.collection , required this.color});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(color)),
      foregroundColor: Colors.white,
      centerTitle: true,
      title:  Text(
        "Discover ${collection.first.type}" ,
        style: const TextStyle(fontWeight: FontWeight.bold ),
      ),

    ),

    body: SingleChildScrollView(
        child: Column(
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox( width: screenWidth(context)*0.8,
                    child: const SearchTextField(productOnly: true,)),
                Icon(Icons.filter_alt) ,
                Icon(Icons.sort_sharp) ,
              ],
            ),
          ) ,
          StaggeredGridView.countBuilder(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: collection.length,
            itemBuilder: (BuildContext context, int index) => Center(
                child: ProductItem(
                  model: collection[index],
                  color: color,
                )),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(1, index.isEven ? 2.2 : 1.4),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 0.0,
          ),
        ],),
      ),
    ) ;
  }
}
