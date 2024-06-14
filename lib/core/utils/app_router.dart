import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppizel/Features/Admin/add_stores.dart';
import 'package:shoppizel/Features/Auth/view/screens/login_screen.dart';
import 'package:shoppizel/Features/Auth/view/screens/sigup_screen.dart';
import 'package:shoppizel/Features/home/view/screens/home_screen.dart';
import 'package:shoppizel/Features/home/view/screens/store_screen.dart';
import 'package:shoppizel/core/utils/app_constants.dart';



 class AppRouter {





  static const signUpScreen = '/signUpView';
  static const loginScreen = '/loginView';
  static const storeScreen = "/storeScreen" ;
  static final router = GoRouter(

    routes: [
      GoRoute(
          path: "/",
          pageBuilder: (context , state) => AppConstants.buildPageWithDefaultTransition<void>(context: context, state: state, child: HomeScreen())
      ),
      GoRoute(
          path: loginScreen,
          pageBuilder: (context , state) => AppConstants.buildPageWithDefaultTransition<void>(context: context, state: state, child: const LoginScreen())
      ),
      GoRoute(
        path: signUpScreen,
          pageBuilder: (context , state) => AppConstants.buildPageWithDefaultTransition<void>(context: context, state: state, child:  SignUpScreen())
      ),


    ],
  );
}
