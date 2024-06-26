import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';

import '../../data/model/category_model.dart';
import '../widgets/home/category_list.dart';

class AllCategories extends StatelessWidget {
  final List<CategoryModel> categories ;
  const AllCategories({super.key , required this.categories});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: (){
          Navigator.pop(context) ;
        },
            child: const Icon(Icons.close , color: AppConstants.appColor ,)),
        title: const Text(
          "Categories" ,
          style: TextStyle(fontWeight: FontWeight.bold , color: AppConstants.appColor),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3 ,  childAspectRatio: 0.7 , mainAxisSpacing: 16),
          itemBuilder: (context , index) => CategoryItem(model: categories[index]) ,
        ),
      ),
    );
  }
}
