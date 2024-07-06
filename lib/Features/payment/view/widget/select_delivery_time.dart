

import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../order/view/widget/delivery_time.dart';

class SelectDeliveryTime extends StatefulWidget {
  final void Function(String?) onSelected;

  const SelectDeliveryTime({super.key ,required this.onSelected});

  @override
  State<SelectDeliveryTime> createState() => _SelectDeliveryTimeState();
}

class _SelectDeliveryTimeState extends State<SelectDeliveryTime> {
  List<String> time =["3 Days" ," 24 Hours" , "3 Hours "] ;
  List<double>addition = [0 , 10 , 20] ;
  int selectedIndex = 0 ;
  @override
  Widget build(BuildContext context) {
    return               Column(
      children: List.generate(3, (index) {
        return GestureDetector(
            onLongPress: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onSelected(time[selectedIndex]) ;
            },
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                DeliveryTime(
                  time: time[index],
                  active: selectedIndex == index ?true : false,

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text("+${addition[index].toStringAsFixed(2)} EGP" , style: TextStyle(color: selectedIndex == index ? Colors.white:AppConstants.appColor ,fontWeight: FontWeight.bold),),
                )
              ],
            )
        );
      },
      ) ,



    )  ;

  }
}