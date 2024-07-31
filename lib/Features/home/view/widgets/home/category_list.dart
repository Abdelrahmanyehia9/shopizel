import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/gender_Cubit.dart';
import 'package:shoppizel/Features/home/controllers/gender_state.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/view/widgets/home/all_product_cat.dart';
import 'package:shoppizel/Features/home/view/screens/all_product_view.dart';
import 'package:shoppizel/core/database/remote/firebase_constant.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/loading_failure.dart';
import '../../../data/model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
        child: SizedBox(
          height: screenHeight(context) * 0.22,
          child: ListView.builder(
            itemCount: 4,
            clipBehavior: Clip.none,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                CategoryItem(model: categories[index]),
          ),
        ));
  }


}
