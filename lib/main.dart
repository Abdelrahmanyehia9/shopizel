import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoppizel/Features/Auth/controller/login_cubit.dart';
import 'package:shoppizel/Features/Auth/view/screens/login_screen.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/home/controllers/gender_Cubit.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/home/view/screens/home_screen.dart';
import 'package:shoppizel/core/utils/app_router.dart';
import 'Features/Auth/controller/sign_up_cubit.dart';
import 'Features/home/controllers/store_cubit.dart';
import 'Features/home/data/repository/store_repo.dart';
import 'core/utils/app_constants.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Tship()) ;


}


class Tship extends StatelessWidget {
  const Tship({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LoginCubit()) ,
        BlocProvider(create: (context)=> SignUpCubit()) ,
        BlocProvider(create: (context)=> HomeCubit(HomeRepo())..fetch() ) ,
        BlocProvider(create:(context)=> StoreCubit(StoreRepo())) ,
        BlocProvider(create:(context)=> GenderCubit(HomeRepo())) ,
        BlocProvider(create:(context)=> FavouriteCubit(FavouriteRepo())) ,



      ],
      child: MaterialApp(
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
highlightColor: Colors.transparent,
            splashColor: Colors.transparent ,
            hoverColor: Colors.transparent ,
            fontFamily: AppConstants.fontFamily,
          appBarTheme: const AppBarTheme(backgroundColor:Color(0xffF3F3F3) ),
          scaffoldBackgroundColor: const Color(0xffF3F3F3) ,


        ),
      ),
    );
  }
}
