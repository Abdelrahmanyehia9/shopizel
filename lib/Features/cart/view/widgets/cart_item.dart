import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppizel/Features/cart/controller/cart_cubit.dart';
import 'package:shoppizel/Features/cart/controller/cart_state.dart';
import 'package:shoppizel/Features/cart/data/repository/cart_repo.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../data/model/cart_model.dart';

class CartItem extends StatefulWidget {
  final CartModel model;
 final  GestureTapCallback removeItemFromCart ;
  const CartItem({super.key, required this.model ,required this.removeItemFromCart});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: screenHeight(context) * .25,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: screenWidth(context) * .3,
                      height: screenHeight(context) * .2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(widget.model.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth(context) * 0.4,
                          child: Text(
                            widget.model.name,
                            maxLines: 2,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Size : ${widget.model.size}",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          "quantity: ${widget.model.quantity}",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Color :",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            CircleAvatar(
                              backgroundColor: Color(int.parse(widget.model.color)),
                              radius: 6,
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                  text: widget.model.sale != "0"
                                      ? (double.parse(widget.model.price) *
                                              widget.model.quantity *
                                              (0.99999 -
                                                  double.parse(widget.model.sale) /
                                                      100.0))
                                          .toStringAsFixed(2)
                                          .split(".")
                                          .first
                                      : (double.parse(widget.model.price) *
                                              widget.model.quantity)
                                          .toStringAsFixed(0),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                    color: AppConstants.appColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          ".${(double.parse(widget.model.price) * widget.model.quantity * (0.99999 - double.parse(widget.model.sale) / 100.0)).toStringAsFixed(2).split(".").last}",
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    const TextSpan(
                                      text: " EGP",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    TextSpan(
                                      text: widget.model.sale != "0"
                                          ? " ${double.parse(widget.model.price) * widget.model.quantity}EGP"
                                          : "",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 9,
                                          decorationColor: Colors.grey),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  widget.model.quantity ++ ;
                                });
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const FaIcon(
                                    FontAwesomeIcons.plus,
                                    size: 14,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(widget.model.quantity.toString()),
                            ),
                            InkWell(
                              onTap: ()async{
                               if(widget.model.quantity>1){

                                 setState(() {
                                   widget.model.quantity --;
                                 });
                               }
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const FaIcon(
                                    FontAwesomeIcons.minus,
                                    size: 14,
                                  )),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            widget.model.sale != "0"
                ? Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.appColor),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "${widget.model.sale}% sale",
                        style: const TextStyle(
                            color: AppConstants.appColor, fontSize: 10),
                      ),
                    ),
                  )
                : const SizedBox(),
            Positioned(
              right: 12,
              bottom: 12,
              child: InkWell(
                onTap: widget.removeItemFromCart ,
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Text(
                    "Remove",
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
