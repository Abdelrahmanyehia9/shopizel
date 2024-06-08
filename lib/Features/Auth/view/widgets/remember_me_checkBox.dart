import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_constants.dart';

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
          activeColor: AppConstants.btnColor,
          value: widget.isChecked,
          onChanged: widget.onChanged,
        ),
        Text(
          "Remember me",
          style: GoogleFonts.sen(fontSize: 13, color: const Color(0xff7E8A97)),
        )
      ],
    );
  }
}
