import 'package:go_router/go_router.dart';
import 'package:shoppizel/Features/Admin/add_stores.dart';
import 'package:shoppizel/Features/Auth/view/screens/login_screen.dart';
import 'package:shoppizel/Features/Auth/view/screens/sigup_screen.dart';
import 'package:shoppizel/Features/home/view/screens/home_screen.dart';
import 'package:shoppizel/Features/home/view/screens/store_screen.dart';



 class AppRouter {
  static const signUpScreen = '/signUpView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>  StoreScreen(),
      ),
      GoRoute(
        path: signUpScreen,
        builder: (context, state) =>  SignUpScreen(),
      ),

    ],
  );
}
