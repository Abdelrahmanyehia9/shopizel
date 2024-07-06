import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';

class DeliveryTime extends StatefulWidget {
final String time;
final bool? active ;
  const DeliveryTime({super.key,required this.time ,this.active});

  @override
  State<DeliveryTime> createState() => _DeliveryTimeState();
}

class _DeliveryTimeState extends State<DeliveryTime> {
  bool hover  = false ;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      hover = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      hover = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(

        onTapDown: _onTapDown ,
        onTapUp: _onTapUp ,
        onTapCancel: (){
          setState(() {
            hover = false ;
          });
        },
        child: Container(
          width: double.infinity,
          height: screenHeight(context) * 0.1,
          decoration: BoxDecoration(
            color:  widget.active==true ? AppConstants.appColor:hover == true ? Colors.teal.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey , width: 0.5)
              ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delivery_dining,
                      color: Colors.grey,
                    ),
                    Text(
                      "Delivery",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text(
                  "Arrive in ${widget.time}",
                  style: TextStyle(color:widget.active==true?Colors.white:hover== true?Colors.white: Colors.black, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
