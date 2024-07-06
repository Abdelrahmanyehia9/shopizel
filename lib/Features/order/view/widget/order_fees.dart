import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/location/controller/location_cubit.dart';
import 'package:shoppizel/Features/location/controller/location_states.dart';
import 'package:shoppizel/Features/order/data/order_fees.dart';
import 'package:shoppizel/Features/order/view/widget/checkout_button.dart';
import 'package:shoppizel/Features/payment/view/screen/choose_payment_method.dart';

import '../screen/order_screen.dart';

class OrderFees extends StatelessWidget {

  final double price;
 final GestureTapCallback? checkoutTapped ;
  final double? discount;

  const OrderFees({super.key, required this.price, this.discount , this.checkoutTapped});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GiftCartTextField(),
        const SizedBox(
          height: 16,
        ),
        feesItem(tittle: "Order", value: "${price.toStringAsFixed(2)}", isSale: true),
        feesItem(tittle: "shipping", value: "40.00"),
        feesItem(
            tittle: "service",
            value: OrderFeesRepo.calcService(price: price-(discount??0.0)).toStringAsFixed(2)
        ),
        discount != null
            ? feesItem(tittle: "discount", value: "-${discount!.toStringAsFixed(2)}")
            : SizedBox(),
        true
            ? SizedBox()
            : feesItem(tittle: "Gift Card ", value: "40", isPromo: true),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        feesItem(
            tittle: "Total",
            value: OrderFeesRepo.calcTotal(
                order: price,
                shipping: 40,
                service: OrderFeesRepo.calcService(price: price-(discount??0.0)) ,
                promoCode: 0.0,
                discount: discount ?? 0).toStringAsFixed(2) ) ,




         CheckoutButton(
           onTap: checkoutTapped  ,

           total: OrderFeesRepo.calcTotal(
            order: price,
            shipping: 40,
            service: price > 1000 ? price * 0.01 : price * 0.015,
            promoCode: 0.0,
            discount: discount ?? 0).toStringAsFixed(2),)
      ],
    );
  }

  Widget feesItem(
      {required String tittle, required value, bool? isPromo, bool? isSale}) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 18, left: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tittle,
            style: TextStyle(
              fontSize: 16,
              color: isPromo != null ? Colors.green : Colors.black,
            ),
          ),
          Text(
            value + " EGP",
            style: TextStyle(
                fontSize: 14,
                decoration: isSale != null
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          )
        ],
      ),
    );
  }
}
