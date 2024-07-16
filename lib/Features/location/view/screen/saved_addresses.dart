import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shoppizel/Features/location/controller/location_cubit.dart';
import 'package:shoppizel/Features/location/data/location_repo.dart';
import 'package:shoppizel/Features/location/view/screen/adress_screen.dart';
import 'package:shoppizel/Features/location/view/widget/location_map.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/loading_failure.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import '../../../shimmer/saved_adress_loading.dart';
import '../../controller/location_states.dart';
import '../../data/model.dart';

class SavedAddresses extends StatefulWidget {
  const SavedAddresses({super.key});

  @override
  State<SavedAddresses> createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  @override
  void initState() {
    BlocProvider.of<LocationCubit>(context).getAllLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Addresses"),
      ),
      body:RefreshIndicator(
        onRefresh: ()async{
          setState(() {
            BlocProvider.of<LocationCubit>(context).getAllLocations() ;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<LocationCubit, LocationStates>(
            builder: (context, state) {
              if (state is GetLocationsStateSuccess) {
                List<LocationModel> locations = state.locations;
                if (locations.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight(context) * .085,
                        ),
                        SizedBox(
                            width: screenWidth(context) * .6,
                            height: screenHeight(context) * .35,
                            child: Image.asset(
                              "assets/images/pngwing.com (35).png",
                              fit: BoxFit.contain,
                            )),
                        const Text(
                          "You Don't Have Any Saved Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () async {
                            Position pos =
                                await LocationRepo.determineDevicePosition();
                            LatLng coordinates =
                                LatLng(pos.latitude, pos.longitude);

                            String locName =
                                await BlocProvider.of<LocationCubit>(context)
                                    .repo
                                    .getLocationName(
                                        lat: coordinates.latitude.toString(),
                                        long: coordinates.longitude.toString());

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LocationMap(
                                        position: coordinates, stName: locName)));
                          },
                          child: Container(
                              width: screenWidth(context) * .6,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppConstants.appColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                  child: Text(
                                "Add Location ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                        )
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: screenHeight(context) * .6,
                        child: ListView.builder(
                            itemCount: state.locations.length,
                            itemBuilder: (context, index) => InkWell(
                                  onDoubleTap: () async {
                                    for (LocationModel model in locations) {
                                      model.isSelected = false;
                                    }
                                    setState(() {
                                      locations[index].isSelected = true;
                                    });
                                    await BlocProvider.of<LocationCubit>(context).repo.selectLocation(locations[index]).whenComplete((){
                                      BlocProvider.of<LocationCubit>(context).getAllLocations() ;
                                    });
                                  },
                                  child: savedLocationItem(
                                      onRemove: () async {
                                        var locationCubit = BlocProvider.of<LocationCubit>(context); // Store the reference

                                        await locationCubit.repo.deleteSelectedItem(locations[index]);

                                        setState(() {
                                          locations.removeAt(index);
                                        });

                                        locationCubit.getAllLocations(); // Use the stored reference
                                      },
                                      context: context,
                                      model: locations[index]),
                                )),
                      ),
                      SizedBox(
                        height: screenHeight(context) * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PrimaryButton(
                              label: "Add New Address",
                              onTap: () async {
                                Position coord =
                                    await LocationRepo.determineDevicePosition();
                                String locName = await LocationRepo()
                                    .getLocationName(
                                        lat: coord.latitude.toString(),
                                        long: coord.longitude.toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LocationMap(
                                              position: LatLng(coord.latitude,
                                                  coord.longitude),
                                              stName: locName,
                                            )));
                              },
                            ),
                            PrimaryButton(
                              label: "Edit Address",
                              onTap: () {
                                LocationModel? model =
                                    BlocProvider.of<LocationCubit>(context)
                                        .repo
                                        .getSelectedLocation(state.locations);
                                if (model != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AddressScreen(
                                                currentPos: LatLng(
                                                    double.parse(model.lat),
                                                    double.parse(model.long)),
                                                tittle: model.tittle,
                                                model: model,
                                              )));
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
              } else if (state is GetLocationsStateFailure) {
                return const LoadingFailure();
              } else {
                return const SavedAddressesLoading() ;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget savedLocationItem(
          {required BuildContext context,
          required LocationModel model,
          GestureTapCallback? onRemove}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              width: screenWidth(context),
              height: screenHeight(context) * 0.375,
              decoration: BoxDecoration(
                color: model.isSelected == true
                    ? AppConstants.appColor
                    : Colors.white,
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
                      height: screenHeight(context) * 0.2,
                      child: FlutterMap(
                        options: MapOptions(
                            keepAlive: true,
                            initialCenter: LatLng(
                              double.parse(model.lat),
                              double.parse(model.long),
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
                                  latitude: 29.952654,
                                  longitude: 30.921919,
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
                            model.name,
                            style: TextStyle(
                                color: model.isSelected == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            model.tittle,
                            style: TextStyle(
                                color: model.isSelected == true
                                    ? Colors.grey.shade300
                                    : Colors.grey),
                          ),
                          Text(
                            "Building: ${model.building}   Floor: ${model.floor}    Flat No: ${model.flatNumber}",
                            style: TextStyle(
                                color: model.isSelected == true
                                    ? Colors.grey.shade300
                                    : Colors.grey,
                                fontSize: 12),
                          ),
                          Text(
                            "01501634466",
                            style: TextStyle(
                                color: model.isSelected == true
                                    ? Colors.grey.shade300
                                    : Colors.grey,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.delete, color: Colors.grey.shade300),
              ),
            )
          ],
        ),
      );
}

