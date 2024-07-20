import 'package:flutter/material.dart';

class bot extends StatelessWidget {
  final String text ;
  const bot({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(text),
    );
  }
}
