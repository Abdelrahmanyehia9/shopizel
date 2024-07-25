import 'package:flutter/material.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class MeasureScreen extends StatelessWidget {
  final String imgModel ;
  const MeasureScreen({super.key , required this.imgModel});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              Container(
                height: screenHeight(context)*.3,
                width: screenWidth(context),
                decoration: BoxDecoration(
                  color: AppConstants.appColor ,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(children: [
                  SizedBox(
                    height: screenHeight(context)*.3,
                    width: screenWidth(context)*.4,
                    child: Image.network(imgModel , fit: BoxFit.cover,),
                  ) ,
                  SizedBox(width: 8,) , 
                  Column(
                    children: [
                    Row(
                      children: [
                        Text("Chest" , style: TextStyle(fontSize: 16 , color:  Colors.white , fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 8,) ,
                        Text("80 cm" , style: TextStyle(fontSize: 14 , color: Colors.grey),)
                      ],
                    ) ,
                      Divider(
                        color: Colors.yellow,
                      )
                  ],)
      
                ],),
              )
      
            ]
          ),
        )
      ),
    );
  }
}
