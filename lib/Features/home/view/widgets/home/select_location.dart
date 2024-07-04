import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../location/controller/location_cubit.dart';
import '../../../../location/data/model.dart';

class SelectALocation extends StatelessWidget {
  final List<LocationModel> locations;

  final GestureTapCallback locationSelected;

  const SelectALocation(
      {super.key, required this.locations, required this.locationSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ))),
          SizedBox(
            height: screenHeight(context) * 0.48,
            child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () async {
                      await BlocProvider.of<LocationCubit>(context)
                          .repo
                          .selectLocation(locations[index])
                          .whenComplete(() {
                        Navigator.pop(context);
                        BlocProvider.of<LocationCubit>(context)
                            .getAllLocations();
                      });
                    },
                    child: locationItem(locations[index]))),
          ),
          const PrimaryButton(label: "Add Location"),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget locationItem(LocationModel location) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          decoration: BoxDecoration(
              color: location.isSelected == true
                  ? AppConstants.appColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: location.isSelected == true
                        ? Colors.grey.shade300
                        : Colors.black,
                  ),
                  Text(
                    location.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: location.isSelected == true
                            ? Colors.white
                            : Colors.black),
                  ),
                ],
              ),
              Text(
                "${location.tittle.split(",").first} - ${location.tittle.split(",").elementAt(1)}",
                style: TextStyle(
                    color: location.isSelected == true
                        ? Colors.grey.shade300
                        : Colors.grey),
              ),
              Text(
                "building: ${location.building}\t\t\tFloor: ${location.floor}\t\t\tFlat No: ${location.flatNumber}",
                style: TextStyle(
                    fontSize: 12,
                    color: location.isSelected == true
                        ? Colors.grey.shade300
                        : Colors.grey),
              )
            ],
          ),
        ),
      );
}
