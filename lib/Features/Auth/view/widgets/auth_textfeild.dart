import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField(
      {super.key,
      required this.controller,
      this.isPassword,
      required this.initialValue,
      this.keyboardType,
      this.validator});

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool? isPassword;

  final String initialValue;
  final TextInputType? keyboardType;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: widget.validator ??
            (value) {
              if (value!.isEmpty) {
                return "this field is required";
              }
            },
        controller: widget.controller,
        obscureText: widget.isPassword == true ? obscureText : !obscureText,
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF0F5FA),
            contentPadding: const EdgeInsets.all(18),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide.none),
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
                : null));
  }
}
