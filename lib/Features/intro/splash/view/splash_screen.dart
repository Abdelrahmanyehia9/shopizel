import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/view/screens/home_screen.dart';
import 'package:shoppizel/core/database/local/shared_prefrences.dart';
import 'package:shoppizel/core/function/permission_handlers.dart';

import '../../../Auth/view/screens/login_screen.dart';
import '../../onBoarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
Future.delayed(const Duration(seconds: 3)  , ()async{
  /// is Not first time
  if (await SharedPreferenceHelper.getBool(SharedPreferenceHelper.isNotFirstTime) &&mounted){

     if (await SharedPreferenceHelper.getBool(SharedPreferenceHelper.isLoggingIn)&& mounted){
       /// first time and logged in
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen() ) , (route)=>false) ;

    }else{
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen() ) , (route)=>false) ;
    }
  }
  else{
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const OnBoardingScreen() ) , (route)=>false) ;

  }


}) ;
    super.initState();
  }
  @override
  void didChangeDependencies()async {

    PermissionHandlers().checkLocationPermission() ;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
