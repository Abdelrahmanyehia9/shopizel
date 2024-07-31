import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shoppizel/core/utils/app_constants.dart';

import '../../../core/database/local/shared_prefrences.dart';
import '../../Auth/view/screens/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  Future<void>_finishedBoarding()async{
    await  SharedPreferenceHelper.setBool(SharedPreferenceHelper.isNotFirstTime, true).whenComplete((){

      Navigator.push(context, MaterialPageRoute(builder: (_)=> const LoginScreen())) ;

    }) ;


  }

  List<PageViewModel>pages = [
    PageViewModel(
      title: "Shopping EveryWhere!",
      body: "The largest collection of clothing stores in one place",
      image: Center(
          child: Image.asset("assets/images/4.png")
      ),
    ),
  PageViewModel(
  title: "Generate outfits",
  body: "Generate Outfits By  Describe your outfit to AI ",
  image: Center(
  child: Image.asset("assets/images/3.png")
  ),
  ),
    PageViewModel(
      title: "Online Fitting Room",
      body: "You can see Clothes on you in online Fitting room",
      image:  Center(
        child: Image.asset("assets/images/1.png" , fit: BoxFit.cover,)
      ),
    ),PageViewModel(

      title: "Body Measure",
      body: "You can Know Your Body Measurement by photo",
      image: Center(
          child: Image.asset("assets/images/2.png" , fit: BoxFit.cover,)
      ),
    )


    ,PageViewModel(
      title: "Body Measure ",
      body: "You can Know Your Body Measurement by photo",
      image: Center(
          child: Image.asset("assets/images/5.png")
      ),
    )


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: pages,
          showSkipButton: true,
          skip: const Text("skip" , style: TextStyle(color: AppConstants.appColor),),
          next: const Icon(Icons.arrow_forward , color: AppConstants.appColor,),
          done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w700 , color: AppConstants.appColor)),
        
          onDone: () async{
            await _finishedBoarding() ;
          },
          onSkip: () async{
            await _finishedBoarding() ;
          },
          dotsDecorator: DotsDecorator(
            size: const Size.square(5.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: AppConstants.appColor ,
            color: Colors.teal.shade100,
            spacing: const EdgeInsets.symmetric(horizontal: 2.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)
            ),
          ),
        ),
      ),
    ) ;
  }
}
