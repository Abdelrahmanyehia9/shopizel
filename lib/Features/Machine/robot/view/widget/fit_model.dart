import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shoppizel/Features/Machine/robot/controller/fitting_room_cubit.dart';
import 'package:shoppizel/Features/Machine/robot/controller/fitting_room_state.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../home/data/model/product_model.dart';

class FitModel extends StatefulWidget {
  final String imgModel;
  final List<ProductModel> products;

  const FitModel({super.key, required this.imgModel, required this.products});

  @override
  _FitModelState createState() => _FitModelState();
}

class _FitModelState extends State<FitModel> {
  ProductModel? selectedProduct ;
  bool errorSelected = false ;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                fittingModel(context),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Choose Outfit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppConstants.appColor),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * .2,
                  child: ListView.builder(
                    itemCount: widget.products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedProduct = widget.products[index];
                            print(selectedProduct!.imageCover) ;
                          });
                        },
                        child: Container(
                          width: screenWidth(context) * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.5,
                              color: selectedProduct == widget.products[index]
                                  ? AppConstants.appColor
                                  : Colors.white,
                            ),
                            boxShadow: AppConstants.shadow,
                            color: AppConstants.appColor,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  widget.products[index].imageCover),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: errorSelected == true ? Colors.red :  Colors.grey.shade400, width: 1),
                      ),
                      width: screenWidth(context) ,
                      height: screenHeight(context) * .5,
                      child: ShowFittedModel()
                    ),
                  ),
                ),
                 PrimaryButton(label: "Apply" , onTap: ()async{
                   if(selectedProduct == null ){
                     setState(() {
                       errorSelected = true ;
                     });
                   }else{


                      BlocProvider.of<FittingRoomCubit>(context).fitModel(modelImg: widget.imgModel, clothesImg: selectedProduct!.imageCover) ;
                   }

                 },)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fittingModel(BuildContext context) => Container(
    padding: const EdgeInsets.all(4),
    width: screenWidth(context),
    height: screenHeight(context) * .15,
    decoration: BoxDecoration(
      boxShadow: AppConstants.shadow,
      borderRadius: BorderRadius.circular(8),
      color: AppConstants.appColor,
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fitting Room",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "You will see clothes on this model. Please choose the outfit you want to see.",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: screenHeight(context) * .25,
            width: screenWidth(context) * .25,
            child: Image.network(
              widget.imgModel,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}


class ShowFittedModel extends StatelessWidget {
  const ShowFittedModel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FittingRoomCubit, FittingRoomState>(
      builder: (context, state) {
        return ClipRect(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity, // Ensure the width is constrained by the parent
              height: double.infinity, // Ensure the height is constrained by the parent
              child: Builder(
                builder: (context) {
                  if (state is FittingRoomStateSuccess) {
                    return PhotoView(
                      gestureDetectorBehavior: HitTestBehavior.opaque,
                      imageProvider: NetworkImage(state.img),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 3,
                      initialScale: PhotoViewComputedScale.contained,
                      strictScale: true,
                      filterQuality: FilterQuality.high,
                      backgroundDecoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      enableRotation: false,
                    );
                  } else if (state is FittingRoomStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppConstants.appColor),
                    );
                  } else if (state is FittingRoomStateFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    );
                  } else {
                    return Text(
                      "Press apply, your photo will appear here",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

