import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final String rate;

  const RatingStars({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow.shade700,
          size: 14,
        ),
        Text(
          rate,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
