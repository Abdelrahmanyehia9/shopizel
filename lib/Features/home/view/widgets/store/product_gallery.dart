import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_item.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../../core/utils/searching.dart';
import '../../../data/model/product_model.dart';
import '../home/search_textfield.dart';

class ProductGallery extends StatefulWidget {
 final List<ProductModel> collection ;
  final String color  ;
  const ProductGallery({super.key ,required this.color , required this.collection});

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  List<ProductModel> filteredCollection = [];




  void _filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCollection = widget.collection;
      });
    } else {
      setState(() {
        filteredCollection = Searching.searchOnProduct(search: query, products: widget.collection);
      });
    }
  }
  final TextEditingController _searchController = TextEditingController() ;

  @override
  void initState() {
    super.initState();
    filteredCollection = widget.collection;

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTextField(productOnly: true, controller: _searchController ,  onChanged: (value) {
          _filterProducts(value);
        },


        ) ,
        StaggeredGridView.countBuilder(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 2,
          itemCount: filteredCollection.length,
          itemBuilder: (BuildContext context, int index) => Center(
              child: ProductItem(
                model: filteredCollection[index],
                color: widget.color,
              )),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(1, index.isEven ? 2.2 : 1.4),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 0.0,
        ),
      ],) ;
  }
}
