import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({super.key, this.sort, this.filter});
final VoidCallback? sort  ;
  final VoidCallback? filter  ;

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          decoration: InputDecoration(
              hintText: "search product",
              border:
              const UnderlineInputBorder(borderSide: BorderSide(width: 2)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Colors.grey.shade700)),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    minSize: double.minPositive,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    onPressed: sort,
                    child: Icon(
                      Icons.sort,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      onPressed: filter,
                      child: Icon(
                        Icons.filter_alt,
                        color: Colors.grey.shade700,
                      ))
                ],
              )),
        ),
      );
  }
}
