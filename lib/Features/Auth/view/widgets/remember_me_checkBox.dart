import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';

class RemeberMe extends StatefulWidget {
  RemeberMe({super.key, required this.isChecked, required this.onChanged});

  bool isChecked;
  final ValueChanged<bool?>? onChanged;

  @override
  State<RemeberMe> createState() => _RemeberMeState();
}

class _RemeberMeState extends State<RemeberMe> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          side: const BorderSide(width: 2, color: Color(0xffE3EBF2)),
          activeColor: AppConstants.appColor,
          value: widget.isChecked,
          onChanged: widget.onChanged,
        ),
        const Text(
          "Remember me",
          style: TextStyle(fontSize: 13, color: Color(0xff7E8A97)),
        )
      ],
    );
  }
}
