import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoppizel/Features/Auth/controller/login_cubit.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/core/utils/app_router.dart';
import 'Features/Auth/controller/sign_up_cubit.dart';
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
        BlocProvider(create: (context)=> HomeCubit(HomeRepo())..fetch() )


      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

            fontFamily: AppConstants.fontFamily,
          appBarTheme: const AppBarTheme(backgroundColor:Color(0xffF3F3F3) ),
          scaffoldBackgroundColor: const Color(0xffF3F3F3) ,


        ),
      ),
    );
  }
}
