import 'package:flutter/material.dart';
import 'package:shoppizel/Features/Auth/view/screens/login_screen.dart';
import 'package:shoppizel/Features/Auth/view/screens/sigup_screen.dart';

void main(){



  runApp(const Shoppizel()) ;


}


class Shoppizel extends StatelessWidget {
  const Shoppizel({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
