import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppizel/core/screen_dimentions.dart';

import '../../../../core/app_constants.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer(
      {super.key,
      required this.tittle,
      required this.subTittle,
      this.isHome , this.emailIfOtpPage
      });

  final String tittle;
final String? emailIfOtpPage ;
  final String subTittle;
  final bool? isHome;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: screenHeight(context) * 0.4,
          decoration: BoxDecoration(
              color: AppConstants.backgroundOfLightTheme,
              image: DecorationImage(
                image: AssetImage(
                  AppConstants.bgPatternAuthContainer,
                ),
                fit: BoxFit.cover,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tittle,
                style: GoogleFonts.sen(color: Colors.white, fontSize: 28),
              ),
              Text(
                subTittle,
                style: GoogleFonts.sen(color: Colors.white, fontSize: 14),
              ),
              Text(
                emailIfOtpPage??"",
                style: GoogleFonts.sen(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 42.0 , horizontal: 16),
          child:isHome == null ?  InkWell(onTap: (){
            Navigator.pop(context) ;
          },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: screenWidth(context)*0.06,
              child:const Icon(Icons.arrow_back_ios  ,size: 20,)  ,
            ),
          ):null,
        )
      ],
    );
  }
}
