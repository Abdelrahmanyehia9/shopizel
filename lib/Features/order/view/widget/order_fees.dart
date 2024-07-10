import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/location/controller/location_cubit.dart';
import 'package:shoppizel/Features/location/controller/location_states.dart';
import 'package:shoppizel/Features/order/data/order_fees.dart';
import 'package:shoppizel/Features/order/view/widget/checkout_button.dart';
import 'package:shoppizel/Features/payment/view/screen/choose_payment_method.dart';
import 'package:shoppizel/Features/promo/data/promo_model.dart';

import '../screen/order_screen.dart';
import 'gift_cart.dart';

class OrderFees extends StatefulWidget {

  final double price;
 final GestureTapCallback? checkoutTapped ;
  final double? discount;

  const OrderFees({super.key, required this.price, this.discount , this.checkoutTapped});

  @override
  State<OrderFees> createState() => _OrderFeesState();
}

class _OrderFeesState extends State<OrderFees> {
  PromoModel? model ;
   double discount =0.0 ;

  @override
  void initState() {
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         GiftCartTextField(total : OrderFeesRepo.calcTotal(
            order: widget.price,
            shipping: 40,
            service: OrderFeesRepo.calcService(price: widget.price-(widget.discount??0.0)) ,
            promoCode: 0.0,
            discount: widget.discount ?? 0).toStringAsFixed(2) ,
         promoGift: (value){
           setState(() {
             model = value ;
             discount = double.parse(model?.discount??"0") ;
           });
         },
         ),
        const SizedBox(
          height: 16,
        ),
        feesItem(tittle: "Order", value: widget.price.toStringAsFixed(2),isSale:widget.discount != null ? true:false  ),
        feesItem(tittle: "shipping", value: "40.00"),
        feesItem(
            tittle: "service",
            value: OrderFeesRepo.calcService(price: widget.price-(widget.discount??0.0)).toStringAsFixed(2)
        ),
        widget.discount != null
            ? feesItem(tittle: "discount", value: "-${widget.discount!.toStringAsFixed(2)}")
            : const SizedBox(),
        model == null
            ? const SizedBox()
            : feesItem(tittle: "Gift Card ", value: discount>1 ? discount.toStringAsFixed(2) : (discount*widget.price).toStringAsFixed(2) , isPromo: true),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        feesItem(
            tittle: "Total",
            value: OrderFeesRepo.calcTotal(
                order: widget.price,
                shipping: 40,
                service: OrderFeesRepo.calcService(price: widget.price-(widget.discount??0.0)) ,
                promoCode: discount > 1 ? discount : discount*widget.price,
                discount: widget.discount ?? 0).toStringAsFixed(2) ) ,




         CheckoutButton(
           onTap: widget.checkoutTapped ,
           total: OrderFeesRepo.calcTotal(
            order: widget.price,
            shipping: 40,
            service: widget.price > 1000 ? widget.price * 0.01 : widget.price * 0.015,
            promoCode: 0.0,
            discount: widget.discount ?? 0).toStringAsFixed(2),)
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
                fontSize: 14,color: isPromo == true ? Colors.green : Colors.black,
                decoration: isSale == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          )
        ],
      ),
    );
  }
}
