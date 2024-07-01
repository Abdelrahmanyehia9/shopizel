import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shoppizel/Features/location/data/location_repo.dart';
import 'package:shoppizel/Features/location/view/screen/adress_screen.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';

import '../../../../core/utils/app_constants.dart';

class LocationMap extends StatefulWidget {
  final LatLng position;
  final String stName;

  const LocationMap({super.key, required this.position, required this.stName});

  @override
  State<LocationMap> createState() => _LocationMarkState();
}

class _LocationMarkState extends State<LocationMap> {
  late LatLng currentPos;
  LocationRepo repo = LocationRepo();
  late String locName;
  MapController mapController = MapController();

  @override
  void initState() {
    currentPos = widget.position;
    locName = widget.stName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppConstants.appColor,
        title: Text("Location"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(

        foregroundColor: Colors.white,
        backgroundColor: AppConstants.appColor,
        onPressed: () async {
          mapController.moveAndRotate(widget.position, 18, 0);
          setState(() {
            locName = widget.stName;
            currentPos = widget.position;
          });
        },
        tooltip: 'Update Location',
        child: const Icon(Icons.my_location),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight(context) * 0.8,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: currentPos,
                initialZoom: 18.0,
                onTap: (position, point) async {
                  setState(() {
                    currentPos = point;
                  });
                  String updName = await repo.getLocationName(lat: currentPos.latitude.toString(), long: currentPos.longitude.toString());
                  setState(() {
                    locName = updName ;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                AnimatedLocationMarkerLayer(moveAnimationDuration: Duration(milliseconds: 300),
                    style: const LocationMarkerStyle(

                        markerSize: Size.square(40),
                        showAccuracyCircle: false,
                        showHeadingSector: false,
                        marker: Icon(
                          Icons.location_on,
                          color: AppConstants.appColor,
                          size: 40,
                        )),
                    position: LocationMarkerPosition(
                        latitude: currentPos.latitude,
                        longitude: currentPos.longitude,
                        accuracy: 0.0)),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight(context) * .2,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: screenHeight(context)*0.02,) ,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0 , horizontal: 12),
                  child: Text(locName , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                ) ,
                PrimaryButton(label: "I live here" , width: screenWidth(context)*.9,onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> AddressScreen(currentPos: currentPos , neighbourhood: locName,)   )) ;
                },)




              ],
            ),
          )
        ],
      ),
    );
  }
}
class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Calculate your custom position
    double x = scaffoldGeometry.scaffoldSize.width -70; // Center horizontally
    double y = scaffoldGeometry.scaffoldSize.height *0.7; // 80 pixels from bottom
    return Offset(x, y);
  }
}