import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppizel/Features/shimmer/saved_adress_loading.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../../home/view/widgets/home/select_location.dart';
import '../../../location/controller/location_cubit.dart';
import '../../../location/controller/location_states.dart';
import '../../../location/data/model.dart';

class ShippingAddress extends StatelessWidget {
  final bool? error ;

  const ShippingAddress({super.key , this.error});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationStates>(
        builder: (context, state) {
          if (state is GetLocationsStateSuccess) {
            return InkWell(
              onLongPress:(){
                showBottomSheet(context: context, builder: (_)=>SelectALocation(locations: state.locations  , locationSelected: (){},)) ;
              } ,
              child: state.selectedLocation == null ? InkWell(onTap: (){
          showBottomSheet(context: context, builder: (_)=>SelectALocation(locations: state.locations  , locationSelected: (){} )); },
                  child: noLocationSelected(context  , error)):
              savedLocationItem(
                  context: context, location: state.selectedLocation!),
            );
          } else {
            return  const SavedAddressesLoading() ;
          }
        });
  }

  Widget savedLocationItem(
      {required BuildContext context,
        GestureTapCallback? onRemove,
        required LocationModel location}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              width: screenWidth(context),
              height: screenHeight(context) * 0.4,
              decoration: BoxDecoration(
               gradient: AppConstants.circularGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: screenWidth(context),
                      height: screenHeight(context) * 0.25,
                      child: FlutterMap(
                        options: MapOptions(
                            keepAlive: true,
                            initialCenter: LatLng(
                              double.parse(location.lat ),
                              double.parse(location.long)
                            ),
                            initialZoom: 18.0,
                            interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.none)),
                        children: [
                          TileLayer(
                              urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app'),
                          AnimatedLocationMarkerLayer(
                              moveAnimationDuration:
                              const Duration(milliseconds: 300),
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
                                  latitude:   double.parse(location.lat ),
                                 longitude: double.parse(location.long) ,
                                  accuracy: 0.0)),
                        ],
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            location.tittle,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Building:${location.building}  Floor: ${location.floor}    Flat No:${location.flatNumber}",
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  Widget noLocationSelected(BuildContext context , bool? error)=>Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Container(
      width: double.infinity,
      height: screenHeight(context)*.4,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration( border: Border.all(color:error != null ? Colors.red :Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(8) , color: AppConstants.appColor),
      child:  Column(mainAxisAlignment: MainAxisAlignment.center,
          children:[
        Text("No Location Selected"  , style : TextStyle(fontSize: 16 , color:error==null? Colors.white:Colors.red)) ,
        const SizedBox(height: 8,) ,
        const Text("Press Here To select a Location " , style: TextStyle(color: Colors.grey),)


      ])
    ),
  ) ;

}
