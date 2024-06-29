import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/cart/controller/cart_cubit.dart';
import 'package:shoppizel/Features/cart/controller/cart_state.dart';
import 'package:shoppizel/Features/cart/data/model/cart_model.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';

import '../../../../core/utils/screen_dimentions.dart';

class AddToCartBtn extends StatefulWidget {
final String color;
final CartModel model ;

  const AddToCartBtn(
      {super.key, required this.color , required this.model
      });

  @override
  State<AddToCartBtn> createState() => _AddToCartBtnState();
}

class _AddToCartBtnState extends State<AddToCartBtn> {

bool _isEnabled = true ;
  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap:  ()async{
print(widget.model.size) ;
print(widget.model.color) ;
       await BlocProvider.of<CartCubit>(context).addToCart(widget.model) ;
      } ,
      child: Container(
          decoration: BoxDecoration(
              color: Color(int.parse(widget.color)),
              borderRadius: BorderRadius.circular(12)),
          width: screenWidth(context) * 0.73,
          height: 60,
          child: BlocBuilder<CartCubit , CartStates>(

            builder:  (context , state)  {

               if (state is AddToCartLoading ){
                 _isEnabled = false ;
                return const Center(child:  CircularProgressIndicator(color: Colors.white,),) ;}
              else{
                return const Center(
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(color: Colors.white),
                    )) ;

              }
            },
          )),
    );
  }
}
