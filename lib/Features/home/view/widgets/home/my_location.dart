import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/view/widgets/home/select_location.dart';

import '../../../../location/controller/location_cubit.dart';
import '../../../../location/controller/location_states.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationStates>(
        builder: (context, state) {
      if (state is GetLocationsStateSuccess) {
        return InkWell(
          onTap: () {
            showBottomSheet(
                context: context,
                builder: (_) => SelectALocation(
                      locations: state.locations,
                    ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.selectedLocation?.name ?? "select a location",
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                )
              ],
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
