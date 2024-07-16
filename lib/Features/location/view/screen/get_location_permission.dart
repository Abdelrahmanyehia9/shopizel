import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppizel/Features/location/data/location_repo.dart';
import 'package:shoppizel/Features/location/view/widget/location_map.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import '../../../../core/function/permission_handlers.dart';
import 'package:latlong2/latlong.dart'  ;

class GetLocationPermission extends StatefulWidget {
  const GetLocationPermission({super.key});

  @override
  State<GetLocationPermission> createState() => _GetLocationPermissionState();
}

class _GetLocationPermissionState extends State<GetLocationPermission> {

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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Text(
            //       "Skip".toUpperCase(),
            //       style: const TextStyle(
            //         fontSize: 18,
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         decoration: TextDecoration.underline,
            //         decorationColor: Colors.white,
            //       ),
            //     ),
            //   ],
            // ),
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
                onTap: () async {
                  LocationRepo repo = LocationRepo() ;
                  PermissionHandlers permission = PermissionHandlers();
                  bool val = await permission.checkLocationPermission();
                  if (val == true) {
                    Position position = await (LocationRepo.determineDevicePosition());
                    LatLng coord = LatLng(position.latitude , position.longitude);
                    String stName = await repo.getLocationName(lat: coord.latitude.toString(), long: coord.longitude.toString()) ;
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LocationMap(position: coord , stName: stName,))) ;

                    });

                  } else {

                  }
                }
            ),
          ],
        ),
      ),
    );
  }


}
