
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_constants.dart';

class PaymentMethods extends StatefulWidget {
  final void Function(String?) onSelected;
  const PaymentMethods({super.key  , required this.onSelected});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  List<String> paymentMethod = ["Cash on delivery", "Credit Card", "E-Wallet", "Other"];
  List<IconData> icons= [FontAwesomeIcons.moneyBill ,FontAwesomeIcons.ccVisa , FontAwesomeIcons.wallet  , Icons.payments] ;
  int _selectedIndex = 0; // Initially, no item is selected

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      primary: false ,
      shrinkWrap: true,
      itemCount: paymentMethod.length,
      itemBuilder: (context, index) {

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(boxShadow: AppConstants.shadow,
                color: Colors.white , borderRadius: BorderRadius.circular(8) , border: Border.all(color: AppConstants.appColor)),
            child: ListTile(
              leading: Radio<int>(
                fillColor: MaterialStateProperty.all(AppConstants.appColor), // Change this to AppConstants.appColor if defined
                value: index,
                groupValue: _selectedIndex,
                onChanged: (int? value) {
                  setState(() {
                    _selectedIndex = value!;
                  });
                  print(paymentMethod[_selectedIndex]) ;
                  widget.onSelected(paymentMethod[_selectedIndex]) ;
                },
              ),
              title: Text(paymentMethod[index] , style: const TextStyle(color: AppConstants.appColor),),
              trailing:                       FaIcon(icons[index] , color: AppConstants.appColor,) ,

              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        );
      },
    ) ;

  }
}