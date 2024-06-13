import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0 , vertical: 4),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search Products, Store",
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xffA0A5BA),
            ),
            hintStyle: TextStyle(color: Color(0xff676767)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            filled: true,
            fillColor: Color(0xffECF0F4)),
      ),
    );
  }
}
