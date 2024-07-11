import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ProductRatingStars extends StatefulWidget {
  final void Function(double?) rateCount ;
  const ProductRatingStars({super.key , required this.rateCount});

  @override
  State<ProductRatingStars> createState() => _ProductRatingStarsState();
}

class _ProductRatingStarsState extends State<ProductRatingStars> {
  double value = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RatingStars(
        value: value,
        onValueChanged: (v) {
          //
          setState(() {
            value = v;
          });
          widget.rateCount(value) ;
        },
        starBuilder: (index, color) => Icon(
          Icons.star,
          color: color,
        ),
        starCount: 5,
        starSize: 20,
        valueLabelColor: const Color(0xff9b9b9b),
        valueLabelTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
        valueLabelRadius: 10,
        maxValue: 5,
        starSpacing: 2,
        maxValueVisibility: true,
        valueLabelVisibility: true,
        animationDuration: const Duration(milliseconds: 1000),
        valueLabelPadding:
        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        valueLabelMargin: const EdgeInsets.only(right: 8),
        starOffColor: const Color(0xffe7e8ea),
        starColor: Colors.yellow,
      ),
    );
  }
}