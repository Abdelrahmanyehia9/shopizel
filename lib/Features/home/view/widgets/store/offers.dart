import 'package:flutter/material.dart';

import '../../../../../core/utils/screen_dimentions.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: screenHeight(context) * 0.2,
        width: screenWidth(context),// Adjust the height as needed
        child: Image.network("https://d1csarkz8obe9u.cloudfront.net/posterpreviews/new-arrival-discount-offer-on-shoes-poster-ad-design-template-20e8be063593e460ec1eadf156df2a71_screen.jpg?ts=1607504280" , fit: BoxFit.cover,),
      ),
    ) ;

  }
}
