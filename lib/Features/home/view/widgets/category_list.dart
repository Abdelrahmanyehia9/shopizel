import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../../../core/utils/app_constants.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        height: screenHeight(context) * 0.22,
        child: ListView(
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          children: [
            categoryItem(
                context: context,
                startingPrice: "40",
                tittle: "Men",
                imageUrl:
                    "https://images.hugoboss.com/is/image/hugobosscsprod/HBME_115_SP24_BOSS_Tier3_BMB_007?%24large%24&cropN=0.0054687,0.0093787,0.646875,0.9390387&align=0,-1&fit=crop,1&ts=1717600951918&qlt=80&wid=720&hei=696"),
            categoryItem(
                context: context,
                startingPrice: "50",
                tittle: "Women",
                imageUrl:
                    "https://media.very.co.uk/i/sd/ctmt-210-womens-dept-1?%24poi%24=&aspect=1%3A1&w=900&qlt=default&fmt=jpg&fmt.jpeg.interlaced=true"),
            categoryItem(
                context: context,
                startingPrice: "9,99",
                tittle: "jewelery",
                imageUrl:
                    "https://africanboutique.in/wp-content/uploads/2023/03/WhatsApp-Image-2023-03-29-at-3.36.10-AM-3.jpeg"),
            categoryItem(
                context: context,
                startingPrice: "69,5",
                tittle: "electronics",
                imageUrl:
                    "https://t4.ftcdn.net/jpg/03/64/41/07/360_F_364410756_Ev3WoDfNyxO9c9n4tYIsU5YBQWAP3UF8.jpg"),
          ],
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
                        fontFamily: AppConstants.fontFamily,
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
                            fontFamily: AppConstants.fontFamily,
                            fontSize: 12,
                            color: Color(0xff646982),
                            height: 0,
                            letterSpacing: 0),
                      ),
                      Text(
                        "$startingPrice\$",
                        style: const TextStyle(
                            fontFamily: AppConstants.fontFamily,
                            fontSize: 12,
                            color: Color(0xff646982)),
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
