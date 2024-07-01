import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/cart/controller/cart_cubit.dart';
import 'package:shoppizel/Features/cart/controller/cart_state.dart';
import 'package:shoppizel/Features/cart/data/model/cart_model.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/function/snackbars.dart';
import 'package:shoppizel/core/utils/app_constants.dart';

import '../../../../core/utils/screen_dimentions.dart';

class AddToCartBtn extends StatefulWidget {
  final String color;
  final CartModel model;

  const AddToCartBtn({super.key, required this.color, required this.model});

  @override
  State<AddToCartBtn> createState() => _AddToCartBtnState();
}

class _AddToCartBtnState extends State<AddToCartBtn> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(listener: (context, state) {
      if (state is AddToCartSuccess) {
        SnackBars.customSnackBar(
            context: context,
            desc: "Item Added Successfully",
            tittle: "Great",
            type: AnimatedSnackBarType.success);
      } else if (state is AddToCartFailure) {
        SnackBars.customSnackBar(
            context: context,
            desc: "Error To added",
            tittle: "Error",
            type: AnimatedSnackBarType.error);
      }
    }, builder: (context, state) {
      if (state is AddToCartLoading) {
        return SizedBox(
            width: screenWidth(context) * .73,
            child:  Center(
              child: CircularProgressIndicator(
                color: Color(int.parse(widget.color))
              ),
            ));
      } else {
        return InkWell(
            onTap: () async {
              await BlocProvider.of<CartCubit>(context).addToCart(widget.model);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color(int.parse(widget.color)),
                  borderRadius: BorderRadius.circular(12)),
              width: screenWidth(context) * 0.73,
              height: 60,
              child: const Center(
                  child: Text(
                "Add To Cart",
                style: TextStyle(color: Colors.white),
              )),
            ));
      }
    });
  }
}
