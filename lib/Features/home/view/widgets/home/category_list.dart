import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/gender_Cubit.dart';
import 'package:shoppizel/Features/home/controllers/gender_state.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/view/widgets/home/all_product_cat.dart';
import 'package:shoppizel/Features/home/view/screens/all_product_view.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/loading_failure.dart';
import '../../../data/model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                CategoryItem(  model: categories[index]),
          ),
        ));
  }


}
class CategoryItem extends StatelessWidget {
  final CategoryModel model ;
  const CategoryItem({super.key , required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),

      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductCat(gender: model.tittle) )) ;
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SizedBox(
              width: screenWidth(context) * 0.32,
              height: screenHeight(context) * 0.2,
            ),
            Container(
              width: screenWidth(context) * 0.32,
              height: screenHeight(context) * 0.17,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(18)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight(context) * 0.09,
                    ),
                    Text(
                      model.tittle,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff32343E),
                          height: 0,
                          letterSpacing: 0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Staring",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff646982),
                              height: 0,
                              letterSpacing: 0),
                        ),
                        Text(
                          "${model.startPrice}£",
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xff646982)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: Container(
                  width: screenWidth(context) * 0.28,
                  height: screenHeight(context) * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      imageUrl: model.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        ///placeholder
                        child: const Center(
                          child: CircularProgressIndicator( color: AppConstants.appColor,),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
