import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/core/function/favourite.dart';

class AddToFavourite extends StatefulWidget {
   bool isFave;
  final ProductModel model ;
   AddToFavourite({super.key ,required  this.isFave , required this.model});

  @override
  State<AddToFavourite> createState() => _AddToFavouriteState();
}

class _AddToFavouriteState extends State<AddToFavourite> {
  @override
  Widget build(BuildContext context) {
    return    Container(

        width: 40,
        height: 40,
        decoration: const BoxDecoration(

            color: Colors.white ,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
        child:  Center(
          child: InkWell(

              onTap: ()async{
        await   Favourite.favHandler(widget.isFave,widget.model) ;
                setState(() {

                  widget.isFave = !(widget.isFave) ;

                });
              },
              child: Icon(widget.isFave != true ?Icons.favorite_border_rounded :Icons.favorite , color: widget.isFave == true ? Colors.red : Colors.black,)),
        ),
      );

  }
}
