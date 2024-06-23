import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/view/widgets/store/constants.dart';

import '../../../../../core/utils/screen_dimentions.dart';

class ClothesCat extends StatelessWidget {
  final String color ;
  final String text ;
  const ClothesCat({super.key , required this.color , required this.text});

  @override
  Widget build(BuildContext context) {

      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color(int.parse(color)).withOpacity(0.8),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(text,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                  SizedBox(
                    width: screenWidth(context) * 0.22,
                    height: screenHeight(context) * 0.12,
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      imageUrl: GenerateImg.getImg(text),
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));

  }
}
