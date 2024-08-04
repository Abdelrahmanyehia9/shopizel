import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppConstants {
  ///colors
  static const Color appColor = Color(0xFF004D40) ;
  static const Color secondColor = Color(0xFF0097A7) ;
  static const Color backgroundOfLightTheme = Color(0xffECF0F4) ;

  ///photos
  static const String bgPatternAuthContainer = "assets/images/BG Asset.png";
  ///font
  static const String fontFamily = "Sen";
  ///api keys
  static  const  String baseUrl = "http://192.168.1.107:5000" ;
static const String geminiApiKey = "AIzaSyCzrGaAqQB1T1lhriUrQCq9bPtyBGlEzB8" ;
///floating action visible
static bool floatingActionVisibility = true;
///gradient
  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00897B) ,
      AppConstants.appColor,
    ],
  );
  static const RadialGradient circularGradient = RadialGradient(
    colors: [
      Color(0xFF00796B) ,

      AppConstants.appColor,
    ],
    center: Alignment.center,
    radius: 0.5
    ,
  ) ;
  /// shadow
  static  List<BoxShadow> shadow =[
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 3,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ]  ;


}
