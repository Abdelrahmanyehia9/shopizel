import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextfeild extends StatefulWidget {
  const AuthTextfeild(
      {super.key,
      required this.controller,
      this.isPassword,
      required this.initialValue,
      this.keyboardType});

  final TextEditingController controller;

  final bool? isPassword;

  final String initialValue;
  final TextInputType? keyboardType;

  @override
  State<AuthTextfeild> createState() => _AuthTextfeildState();
}

class _AuthTextfeildState extends State<AuthTextfeild> {
  bool obscuretext = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color(0xffF0F5FA)),
      child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword == true ? obscuretext : !obscuretext,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(18),
              border: InputBorder.none,
              hintStyle: GoogleFonts.sen(
                color: const Color(0xffA0A5BA ) , fontSize: 14 ,
              ),
              hintText: widget.initialValue,
              suffixIcon: widget.isPassword == true
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          obscuretext = !obscuretext;
                        });
                      },
                      child: obscuretext == false
                          ? const Icon(Icons.visibility , color: Color(0xffB4B9CA),)
                          : const Icon(Icons.visibility_off , color: Color(0xffB4B9CA),))
                  : null)),
    );
  }
}
