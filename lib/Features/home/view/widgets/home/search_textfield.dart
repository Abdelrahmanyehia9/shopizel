import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
 final ValueChanged<String>? onChanged ;
  final TextEditingController controller ;
  const SearchTextField({super.key , this.productOnly , required this.controller , this.onChanged });
final bool? productOnly ;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:  8.0 , vertical: 4),
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
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            filled: true,
            fillColor: const Color(0xffECF0F4)),
      ),
    );
  }
}
