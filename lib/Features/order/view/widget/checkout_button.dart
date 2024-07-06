import 'package:flutter/material.dart';
import '../../../../core/utils/app_constants.dart';

class CheckoutButton extends StatelessWidget {
  final GestureTapCallback? onTap ;
  final String total ;
  const CheckoutButton({super.key , required this.total , this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: InkWell(
        onTap:onTap ,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: AppConstants.gradient,
              borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.all(18),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Checkout",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
              Row(
                children: [
                  Text(
                    "${total} EGP",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
