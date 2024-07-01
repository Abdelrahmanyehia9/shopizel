import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoppizel/Features/location/data/location_repo.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import '../../../../core/function/permission_handlers.dart';

class GetAccessLocation extends StatefulWidget {
  const GetAccessLocation({super.key});

  @override
  State<GetAccessLocation> createState() => _GetAccessLocationState();
}

class _GetAccessLocationState extends State<GetAccessLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade800,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Skip".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * .08,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
              width: screenWidth(context),
              height: screenHeight(context) * .5,
              child: Lottie.asset(
                "assets/images/Location (1).json",
                fit: BoxFit.fitWidth,
              ),
            ),
            PrimaryButton(
              color: Colors.white,
              label: "Share Location ",
              onTap: ()async{
                PermissionHandlers permission = PermissionHandlers();
                bool val= await permission.checkLocationPermission() ;
if (val == true){
            // Position position    = await LocationRepo.determineDevicePosition() ;
 // print("lat ${position.latitude} long ${position.longitude}") ;
}
              }
            ),
          ],
        ),
      ),
    );
  }


}
