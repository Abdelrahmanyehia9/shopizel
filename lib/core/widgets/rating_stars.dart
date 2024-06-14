import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
          Icon(Icons.star , color:  Colors.yellow.shade700, size: 14,) ,
          Icon(Icons.star , color:  Colors.yellow.shade700, size: 14,) ,
          Icon(Icons.star , color:  Colors.yellow.shade700, size: 14,) ,
          Icon(Icons.star , color:  Colors.yellow.shade700, size: 14,) ,
        ],




    )  ;

  }
}
