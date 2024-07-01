import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shoppizel/Features/location/controller/location_cubit.dart';
import 'package:shoppizel/Features/location/controller/location_states.dart';
import 'package:shoppizel/Features/location/data/model.dart';
import 'package:shoppizel/core/function/validation.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import '../widget/type_of_location.dart';

class AddressScreen extends StatefulWidget {
  final LatLng currentPos;
  final String? neighbourhood ;

  const AddressScreen({super.key, required this.currentPos , this.neighbourhood});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String selectedLocation = "Building";
  final TextEditingController _neighbourhood = TextEditingController();
  final TextEditingController _tiitle = TextEditingController();
  final TextEditingController _building = TextEditingController();
  final TextEditingController _floor = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _flatno = TextEditingController();
  final TextEditingController _specialMark = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
_neighbourhood.text = widget.neighbourhood??"" ;
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("address"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight(context) * 0.3,
                child: FlutterMap(
                  options: MapOptions(
                      keepAlive: true,
                      initialCenter: widget.currentPos,
                      initialZoom: 18.0,
                      interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.none)),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
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
                            latitude: widget.currentPos.latitude,
                            longitude: widget.currentPos.longitude,
                            accuracy: 0.0)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fieldOfAddress(
                        label: "Neighbourhood",
                        controller: _neighbourhood,
                        valid: true),
                    fieldOfAddress(
                        label: "tittle",
                        controller: _tiitle,
                        hint: "address specifically"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: screenWidth(context) * 0.32,
                            child: fieldOfAddress(
                                label: "Building", controller: _building)),
                        SizedBox(
                            width: screenWidth(context) * 0.22,
                            child: fieldOfAddress(
                                label: "Floor",
                                controller: _floor,
                                inputType: TextInputType.number)),
                        SizedBox(
                            width: screenWidth(context) * 0.22,
                            child: fieldOfAddress(
                                label: "Flat NO", controller: _flatno)),
                      ],
                    ),
                    fieldOfAddress(
                        label: "Special Mark Address",
                        controller: _specialMark,
                        hint: "ex. Cairo-university"),
                    const Text(
                      "Live in",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TypeOfLocation(
                      onSelected: (value) {
                        setState(() {
                          selectedLocation = value!;
                        });
                      },
                    ),
                    fieldOfAddress(
                        label: "Name Of Address",
                        controller: _name,
                        hint: "ex. Villa "),
                    BlocBuilder<LocationCubit, LocationStates>(
                        builder: (context, state) {
                          if (state is AddLocationStateLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppConstants.appColor,
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: PrimaryButton(
                                label: "Confirm",
                                onTap: () {
                                  if (_globalKey.currentState!.validate()) {
                                    LocationModel model = LocationModel(
                                        tittle: _tiitle.text,
                                        building: _building.text,
                                        flatNumber: _flatno.text,
                                        floor: int.parse(_floor.text),
                                        specialMark: _specialMark.text,
                                        lat: widget.currentPos.latitude.toString(),
                                        long: widget.currentPos.longitude.toString(),
                                        name: _name.text,
                                        type: selectedLocation) ;

                                    BlocProvider.of<LocationCubit>(context)
                                        .addLocation(model) ;
                                  }
                                },
                              ),
                            );
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldOfAddress({required String label,
    String? hint,
    required TextEditingController controller,
    bool? valid,

    TextInputType? inputType}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              onChanged: (value){
                setState(() {
                  _globalKey.currentState!.validate() ;

                });
              },
              keyboardType: inputType ?? TextInputType.text,
              controller: controller,
              validator: valid == null
                  ? (value) {
                if (Validation.validationNotNull(value ?? "")) {
                  return "this field is required";
                } else {
                  return null;
                }
              }
                  : null,
              decoration: InputDecoration(
                  filled: true,
                  hintText: hint ?? "",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none)),
            )
          ],
        ),
      );
}
