import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_gallery.dart';
import 'package:shoppizel/core/utils/searching.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../data/model/product_model.dart';

class SearchingProducts extends StatelessWidget {
  final List<ProductModel> collection;
  final String color;

  const SearchingProducts({super.key, required this.collection, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(

        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
             floating: false,
              pinned: false,
              backgroundColor: Color(int.parse(color)),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Discover ${collection.first.type}",
                  style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
                ),
                background: Container(
                  color: Color(int.parse(color)),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: ProductGallery(color: color, collection: collection),
        ),
      ),
    );
  }
}
