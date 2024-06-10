import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Auth/controller/authentication_cubit.dart';
import 'package:shoppizel/Features/Auth/view/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoppizel/core/utils/app_router.dart';
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
        BlocProvider(create: (context)=> SignUpCubit())

      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
