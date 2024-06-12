import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key, required this.tittle});

  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tittle,
          style: const TextStyle(
            color: Color(0xff32343E),
            fontSize: 18,
          ),
        ),
        const Row(
          children: [
            Text(
              "See All",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffA0A5BA),
              size: 16,
            ),
          ],
        )
      ],
    );
  }
}
