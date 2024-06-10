import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextfeild extends StatefulWidget {
  const AuthTextfeild(
      {super.key,
      required this.controller,
      this.isPassword,
      required this.initialValue,
      this.keyboardType
      ,this.validator
      });

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool? isPassword;

  final String initialValue;
  final TextInputType? keyboardType;

  @override
  State<AuthTextfeild> createState() => _AuthTextfeildState();
}

class _AuthTextfeildState extends State<AuthTextfeild> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color(0xffF0F5FA)),
      child: TextFormField(
          validator: widget.validator ?? (value) {
            if (value!.isEmpty) {
              return "this field is required";
            }
          },
          controller: widget.controller,
          obscureText: widget.isPassword == true ? obscureText : !obscureText,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(18),
              border: InputBorder.none,
              hintStyle: GoogleFonts.sen(
                color: const Color(0xffA0A5BA),
                fontSize: 14,
              ),
              hintText: widget.initialValue,
              suffixIcon: widget.isPassword == true
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: obscureText == false
                          ? const Icon(
                              Icons.visibility,
                              color: Color(0xffB4B9CA),
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Color(0xffB4B9CA),
                            ))
                  : null)),
    );
  }
}
