import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class SearchTextField extends StatelessWidget {
 final ValueChanged<String>? onChanged ;
  final TextEditingController controller ;
  const SearchTextField({super.key , this.productOnly , required this.controller , this.onChanged });
final bool? productOnly ;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:  4.0 , vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(color: Colors.white ,
        borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: screenWidth(context)*0.75,
              child: TextField(

                onChanged: onChanged,
                controller: controller,
                decoration: InputDecoration(

                    hintText: productOnly == null  ?"Search Products, Store":"Search Product",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xffA0A5BA),
                    ),
                    hintStyle: const TextStyle(color: Color(0xff676767)),
                    border: InputBorder.none ,
                    ),
              ),
            ),
            const Icon(Icons.filter_alt) ,
            const Icon(Icons.sort_sharp) ,
          ],
        ),
      ),
    );
  }
}
