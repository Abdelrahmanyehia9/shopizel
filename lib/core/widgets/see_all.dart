import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key, required this.tittle});

  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tittle,
            style: const TextStyle(
              fontSize: 18,

            ),
          ),
           const Row(
            children: [
              Text(
                "See All",
                style: TextStyle(fontSize: 16 ,
                color: Colors.grey),
              ),
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          )
        ],
      ),
    );
  }
}
