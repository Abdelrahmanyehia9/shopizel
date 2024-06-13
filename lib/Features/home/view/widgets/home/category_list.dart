import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../data/model/category_model.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 , horizontal: 5),
      child: SizedBox(
        height: screenHeight(context) * 0.22,
        child: ListView.builder(
          itemCount: 4,
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => categoryItem(
              context: context,
              tittle: categories[index].tittle,
              startingPrice: categories[index].startPrice.toString(),
              imageUrl: categories[index].imageUrl),
        ),
      ),
    );
  }

  Widget categoryItem(
      {required BuildContext context,
      required String tittle,
      required String startingPrice,
      required imageUrl}) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
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
                    tittle,
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
                        "$startingPrice\$",
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
                  image: DecorationImage(
                      image: NetworkImage(
                        imageUrl,
                      ),
                      fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }
}
