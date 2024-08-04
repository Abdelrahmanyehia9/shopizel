import 'package:flutter/material.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../data/model/clothes_measure_model.dart';

class SizeMeasureContainer extends StatelessWidget {
  final String imgModel ;
  final ClothesMeasureModel model  ;
  final String size  ;
  const SizeMeasureContainer({super.key , required this.imgModel , required this.model , required this.size});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(8),
      height: screenHeight(context) * .3,
      width: screenWidth(context),
      decoration: BoxDecoration(
        color: AppConstants.appColor,
        boxShadow: AppConstants.shadow ,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            height: screenHeight(context) * .3,
            width: screenWidth(context) * .35,
            child: ClipRRect(borderRadius: BorderRadius.circular(8),
                child: Image.network(imgModel, fit: BoxFit.cover)),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeItem(context , "Width"  , model.chestWidth.toStringAsFixed(0)),
              sizeItem(context , "Height"  , model.frontLength.toStringAsFixed(0)),
              sizeItem(context , "Sleeve"  , model.sleeveLength.toStringAsFixed(0)),
              sizeItem(context , "Size"  , size)


            ],
          ),
        ],
      ),
    )
    ;
  }
  Widget sizeItem(context ,String tittle   , String value)=>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                tittle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12,) ,
              Text(  overflow: TextOverflow.ellipsis ,
                tittle=="Size"? value: "${value}cm",
                style:  TextStyle(
                  fontSize: 12,
                  color: tittle == "Size" ? Colors.yellow :Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: screenWidth(context) * .5,
            child: const Divider(
              color: Colors.grey, // or any color you prefer
              thickness: 1,
            ),
          ),
        ],
      )  ;

}
