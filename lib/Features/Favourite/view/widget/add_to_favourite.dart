import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_state.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/home/controllers/gender_Cubit.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';

class AddToFavourite extends StatelessWidget {
  final bool? isFave ;
  final ProductModel model ;
  const AddToFavourite({super.key ,  this.isFave , required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavouriteCubit , FavouriteStates>(
      listener: (context , state) {
        if(state is  AddFavouriteStateSuccess){
          print("success") ;
        }
        else if (state is AddFavouriteStateFailure){
          print(state.errorMsg) ;

        }
        else{
          print("Loading") ;
        }
      }



  ,  child:    Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
        child:  Center(
          child: InkWell(
              onTap: ()async{
                await context.read<FavouriteCubit>().addToFavourite(model) ;

              },
              child: Icon(isFave != true ?Icons.favorite_border_rounded :Icons.favorite , color: isFave == true ? Colors.red : Colors.black,)),
        ),
      ),
    );
  }
}
