import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/order/data/order_fees.dart';
import 'package:shoppizel/Features/order/view/widget/checkout_button.dart';
import 'package:shoppizel/Features/promo/controller/promo_state.dart';
import '../../../promo/controller/promo_cubit.dart';
import 'gift_cart.dart';

class OrderFees extends StatefulWidget {
  final double price;
  final GestureTapCallback? checkoutTapped;
  final void Function(String?) fees ;
  final double? discount;

  const OrderFees(
      {super.key, required this.price, this.discount, this.checkoutTapped ,required this.fees});

  @override
  State<OrderFees> createState() => _OrderFeesState();
}

class _OrderFeesState extends State<OrderFees> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GiftCartTextField(
          total: OrderFeesRepo.calcTotal(
                  order: widget.price,
                  shipping: 40,
                  service: OrderFeesRepo.calcService(
                      price: widget.price - (widget.discount ?? 0.0)),
                  promoCode: 0.0,
                  discount: widget.discount ?? 0)
              .toStringAsFixed(2),
        ),
        const SizedBox(
          height: 16,
        ),
        feesItem(
            tittle: "Order",
            value: widget.price.toStringAsFixed(2),
            isSale: false),
        feesItem(tittle: "shipping", value: "40.00"),
        feesItem(
            tittle: "service",
            value: OrderFeesRepo.calcService(
                    price: widget.price - (widget.discount ?? 0.0))
                .toStringAsFixed(2)),
        widget.discount != null
            ? feesItem(
                tittle: "discount",
                value: "-${widget.discount!.toStringAsFixed(2)}")
            : const SizedBox(),
        BlocBuilder<PromoCubit, PromoState>(builder: (context, state) {
          if (state is ApplyPromoSuccess) {
            return feesItem(
                tittle: "Gift Card ",
                value: state.discount > 1
                    ? "-${state.discount.toStringAsFixed(2)}"
                    : "-${(state.discount * widget.price).toStringAsFixed(2)}",
                isPromo: true);
          } else {
            return const SizedBox();
          }
        }),
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
                    service: OrderFeesRepo.calcService(
                        price: widget.price - (widget.discount ?? 0.0)),
                    promoCode: 0,
                    discount: widget.discount ?? 0)
                .toStringAsFixed(2)),

        BlocBuilder<PromoCubit, PromoState>(
          builder: (context, state) {
            if (state is ApplyPromoSuccess) {
              double discount = widget.discount ?? 0;
              if (state.promoModel.minOrder > (widget.price - discount)) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                  child: Text(
                    "add ${(state.promoModel.minOrder - (widget.price-discount)).toStringAsFixed(2)} EGP to Your order To complete ",
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              widget.fees(OrderFeesRepo.calcTotal(
                  order: widget.price,
                  discount: widget.discount ?? 0,
                  shipping: 40,
                  service: OrderFeesRepo.calcService(
                      price: widget.price - (widget.discount ?? 0.0)),
                  promoCode: state.discount>1?state.discount:state.discount*widget.price).toStringAsFixed(2)  );
              return CheckoutButton(
                  onTap: widget.checkoutTapped,
                  total: (OrderFeesRepo.calcTotal(
                          order: widget.price,
                          discount: widget.discount ?? 0,
                          shipping: 40,
                          service: OrderFeesRepo.calcService(
                              price: widget.price - (widget.discount ?? 0.0)),
                          promoCode: state.discount>1?state.discount:state.discount*widget.price).toStringAsFixed(2)) );
            } else {
              widget.fees(OrderFeesRepo.calcTotal(
                  order: widget.price,
                  discount: widget.discount ?? 0,
                  shipping: 40,
                  service: OrderFeesRepo.calcService(
                      price: widget.price - (widget.discount ?? 0.0)),
                  promoCode: 0).toStringAsFixed(2)  );
              return CheckoutButton(
                  onTap: widget.checkoutTapped,
                  total: (OrderFeesRepo.calcTotal(
                          order: widget.price,
                          discount: widget.discount ?? 0,
                          shipping: 40,
                          service: OrderFeesRepo.calcService(
                              price: widget.price - (widget.discount ?? 0.0)),
                          promoCode: 0))
                      .toStringAsFixed(2));
            }
          },
        )
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
                color: isPromo == true ? Colors.green : Colors.black,
                decoration: isSale == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          )
        ],
      ),
    );
  }
}
