import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../data/promo_model.dart';
import '../../data/promo_code_repo.dart';

class PromoCodeItem extends StatelessWidget {
  final PromoModel promoModel;

  const PromoCodeItem({super.key, required this.promoModel});

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: AppConstants.shadow,
            borderRadius: BorderRadius.circular(4)),
        width: double.infinity,
        height: screenHeight(context) * 0.25,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: AssetImage(AppConstants.bgPatternAuthContainer),
                        fit: BoxFit.cover)),
                height: screenHeight(context) * 0.25,
                width: screenWidth(context) * 0.4,
                child: Center(
                  child: Text(
                    promoModel.code,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight(context) * .015,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Save ${double.parse(promoModel.discount!) > 1 ? "${promoModel.discount}EGP" : "${(double.parse(promoModel.discount!) * 100).toStringAsFixed(0)}%"}  On next Order For ${promoModel.store} Using code ${promoModel.code}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Text(
                    promoModel.validation != null
                        ? "valid till ${DateFormat('dd-MM-yyyy').format(DateTime.parse(promoModel.validation!))}"
                        : "Valid",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                   Text("Min Order : ${promoModel.minOrder} EGP" , style: TextStyle(fontSize: 12 , color: Colors.grey.shade600),) ,
                  Row(
                    children: [
                      Text("Status :  " , style: TextStyle(fontSize: 12 , color: Colors.grey.shade600),) ,
                      Text(
                        (DateTime.now().isBefore(DateTime.parse(promoModel.validation ?? DateTime(2028).toString()))) ? "Available" : "Expired",
                        style: TextStyle(fontSize: 12, color:(DateTime.now().isBefore(DateTime.parse(promoModel.validation ?? DateTime(2028).toString())))?Colors.green :Colors.red ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  (DateTime.now().isBefore(DateTime.parse(
                      promoModel.validation ?? DateTime(2028).toString())))
                      ? ElevatedButton(
                    onPressed: () async{

                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        fixedSize: Size(screenWidth(context) * 0.475, 20),
                        backgroundColor: AppConstants.appColor,
                        shape: const RoundedRectangleBorder()),
                    child: const Text("USE"),
                  )
                      : const SizedBox(),
                  SizedBox(
                    height: screenHeight(context) * .01,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
