import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoppizel/Features/Auth/controller/auth_cubit.dart';
import 'package:shoppizel/Features/Auth/view/screens/profile_screen.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/cart/data/repository/cart_repo.dart';
import 'package:shoppizel/Features/cart/view/screen/cart_screen.dart';
import 'package:shoppizel/Features/home/controllers/gender_Cubit.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'Features/cart/controller/cart_cubit.dart';
import 'Features/home/controllers/store_cubit.dart';
import 'Features/home/data/repository/store_repo.dart';
import 'Features/home/view/screens/home_screen.dart';
import 'core/utils/app_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Tship());
}

class Tship extends StatelessWidget {
  const Tship({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit(HomeRepo())..fetch()),
        BlocProvider(create: (context) => StoreCubit(StoreRepo())),
        BlocProvider(create: (context) => GenderCubit(HomeRepo())),
        BlocProvider(create: (context) => FavouriteCubit(FavouriteRepo())),
        BlocProvider(create: (context) => CartCubit(CartRepo())..fetchCartProducts()),

      ],
      child: MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          fontFamily: AppConstants.fontFamily,
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xffF3F3F3)),
          scaffoldBackgroundColor: const Color(0xffF3F3F3),
        ),
      ),
    );
  }
}
