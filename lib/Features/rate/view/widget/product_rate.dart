import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class ProductRate extends StatelessWidget {
  const ProductRate({super.key});

  @override
  Widget build(BuildContext context) {
    return  ExpandablePanel(

        theme: const ExpandableThemeData(
          tapHeaderToExpand: true,
          iconPadding: EdgeInsets.zero,
          hasIcon: true,
        ),
        collapsed: const SizedBox(),
        header: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("4.3" , style: TextStyle(fontWeight: FontWeight.bold),) ,
            Icon(Icons.star , color: Colors.yellow.shade700,size: 18,) ,
            SizedBox(width: 4,) ,
            const Text("(1500 Reviews)" , style: TextStyle(fontSize: 12 , color: Colors.grey  ,decoration: TextDecoration.underline , decorationColor: Colors.grey),),
          ],
        ),
        expanded: SizedBox(height: screenHeight(context)*0.6,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
                physics: BouncingScrollPhysics() ,
                itemCount: 49,padding: EdgeInsets.zero,
                itemBuilder: (context , index)=>rateItem(context)),
          ),
        )


    );


  }
  Widget rateItem(context)=>Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white ,
        borderRadius: BorderRadius.circular(8 )
      ),
      height: screenHeight(context)*.1,
      child: const Row(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        CircleAvatar(

        ) ,
        SizedBox(width: 12,) ,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 12),) ,
            RatingStars(value: 3,
            starSize: 12, valueLabelTextStyle: TextStyle(fontSize: 8 , color: Colors.white),) ,
            Text("good kv fjkjd kj" ,style: TextStyle(color: Colors.grey , fontSize: 10),)
          ],
        )
      ],),
    ),
  ) ;
}