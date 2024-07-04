import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/view/screens/product_spacific_cat.dart';
import 'package:shoppizel/Features/home/view/widgets/home/search_textfield.dart';
import 'package:shoppizel/Features/home/view/widgets/store/clothes_cat.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_gallery.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_item.dart';

import '../../../../core/utils/screen_dimentions.dart';
import '../../data/repository/store_repo.dart';

class AllProductView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  final List<ProductModel> collection;
  final List<String> categories;

  final String color;

  AllProductView(
      {super.key,
      required this.color,
      required this.collection,
      required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(int.parse(color)),
            title: Text("${collection.first.madeBy}"),
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.19,
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) => ClothesCat(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SearchingProducts(
                                collection: StoreRepo().getTypeOfClothes(
                                    collection, categories[index]),
                                color: color,
                              ),
                            ),
                          );
                        },
                        color: color,
                        text: categories[index],
                      ),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                ProductGallery(color: color, collection: collection),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
