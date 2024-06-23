import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key, required this.tittle , this.onTap});
final GestureTapCallback? onTap ;
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tittle,
            style: const TextStyle(
              fontSize: 18,

            ),
          ),
            Row(
            children: [
              InkWell(
                onTap:onTap ,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "See All",
                    style: TextStyle(fontSize: 16 ,
                    color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              const Icon(
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
