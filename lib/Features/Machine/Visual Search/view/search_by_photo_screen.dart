import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/controller/search_by_photo_cubit.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/controller/search_by_photo_states.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/view/widgets/store/product_gallery.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../../home/view/widgets/store/product_item.dart';

class SearchByPhotoScreen extends StatefulWidget {
  final File photo;

  const SearchByPhotoScreen({super.key, required this.photo});

  @override
  State<SearchByPhotoScreen> createState() => _SearchByPhotoScreenState();
}

class _SearchByPhotoScreenState extends State<SearchByPhotoScreen> {
  @override
  void initState() {
    BlocProvider.of<SearchByPhotoCubit>(context).fetch(image: widget.photo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchByPhotoCubit, SearchByPhotoStates>(
          builder: (context, state) {
        if (state is SearchByPhotoStateSuccess) {
          
          return SingleChildScrollView(
            child: Column(
              children: [
                StaggeredGridView.countBuilder(
                  primary: false,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  itemCount: state.products.length,
                  itemBuilder: (BuildContext context, int index) {
                   double simScore = state.predicted[index].simScore*100.ceil() ;
                    return Center(
                      child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ProductItem(
                        model: state.products[index],
                        color: AppConstants.appColor.value.toString(),
                      ),
                      simScore > 30 ?Container(
                        decoration: BoxDecoration(
                            color: AppConstants.secondColor,
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Match ${(simScore < 90 ?  simScore +  10 : simScore).toStringAsFixed(0)}%",
                          style: TextStyle(color: Colors.white, fontSize: 10 , fontWeight: FontWeight.bold),
                        ),
                      ):const SizedBox()
                    ],
                  ));
                  },
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(1, index.isEven ? 2.2 : 1.4),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 0.0,
                ),
              ],
            ),
          );
        } else if (state is SearchByPhotoStateFailure) {
          print(state.errorMessage);
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
