import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/view/widgets/home/search_textfield.dart';
import 'package:shoppizel/Features/home/view/widgets/store/clothes_cat.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_item.dart';

import '../../../../core/utils/screen_dimentions.dart';

class AllProductView extends StatelessWidget {
  final List<ProductModel> collection;
 final List<String> categories ;
  final String color;

  const AllProductView(
      {super.key, required this.color, required this.collection , required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          scrolledUnderElevation: 0,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),

                child: SizedBox(
                  height: screenHeight(context) * 0.19,
                  child: ListView.builder(
                    itemCount: categories.length ,
                    itemBuilder: (context, index) => ClothesCat(
                        color: color,
                        text: categories[index]),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
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
            ],
          ),
        ));
  }
}
