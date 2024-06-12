import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/view/widgets/store/offers.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../widgets/store/list_store_category.dart';
import '../widgets/store/search_product.dart';
import '../widgets/store/shop_gallery.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CategorySelectionBar(),
          const SizedBox(
            height: 24,
          ),
          const SearchProduct(),
          const SizedBox(
            height: 12,
          ),
              const Expanded(
                child: CustomScrollView(
                  slivers: [
                    Offers() ,
                    SliverToBoxAdapter(
                      child: SizedBox(height: 8), // Adjust the space as needed
                    ),
                    ShopGallery()

                  ],
                ),
              )
        ],
      ),
    )));
  }


}
