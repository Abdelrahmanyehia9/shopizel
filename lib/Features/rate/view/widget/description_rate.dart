import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';

class DescriptionRate extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionRate({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          child: TextFormField(
            controller: controller,
            maxLines: 3,
            cursorColor: AppConstants.appColor,
            decoration: InputDecoration(
                hintText: "ex. Very Good Material",
                filled: true,
                fillColor: Colors.white.withOpacity(0.75),
                border: const OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ],
    );
  }
}
