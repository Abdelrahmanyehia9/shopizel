import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppConstants{

  static  const Color btnColor =  Color(0xffFF7622);
  static const Color backgroundOfLightTheme =  Color(0xff1E1E2E);
   static  const String bgPatternAuthContainer = "assets/images/BG Asset.png";
   static  const String fontFamily  = "Sen"  ;
   static const LinearGradient gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppConstants.btnColor, Colors.deepOrange],
) ;
 static  CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
   Duration? duration
  }) {
    return CustomTransitionPage<T>(
      transitionDuration: duration ?? const Duration(milliseconds: 400),
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity:               CurveTween(curve: Curves.easeInOutCirc).animate(animation),  child: child ),
    );
  }


}