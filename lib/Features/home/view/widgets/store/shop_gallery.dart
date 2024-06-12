import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';

class ShopGallery extends StatelessWidget {
  const ShopGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.4,
        crossAxisCount: 2, // Number of columns in the grid
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 5.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: Image.network(
                    "https://static.zara.net/assets/public/f01c/8d06/de7646468994/1979fb24205b/03897074712-p/03897074712-p.jpg?ts=1717749644200&w=824",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "t-shirt good with low price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              productRate() ,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: screenHeight(context) * 0.06,
                  decoration: const BoxDecoration(
                    gradient: AppConstants.gradient
                  ),
                  child: const Center(
                      child: Text(
                    "Add To Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  )),
                ),
              )
            ],
          );
        },
        childCount: 20, // Number of grid items
      ),
    );
  }
  Widget productRate()=>  Row(
    children: [
      Icon(
        Icons.star,
        color: Colors.yellow.shade700,
      ),
      Icon(
        Icons.star,
        color: Colors.yellow.shade700,
      ),
      Icon(
        Icons.star,
        color: Colors.yellow.shade700,
      ),
      Icon(
        Icons.star_border_outlined,
        color: Colors.yellow.shade700,
      ),
      Icon(
        Icons.star_outline,
        color: Colors.yellow.shade700,
      ),
    ],
  ) ;

}
