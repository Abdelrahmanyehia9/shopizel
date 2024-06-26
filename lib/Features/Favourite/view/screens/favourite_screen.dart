import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_state.dart';
import 'package:shoppizel/Features/Favourite/view/widget/product_item_vertical_view.dart';
import 'package:shoppizel/core/utils/app_constants.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: AppBar(
           backgroundColor: AppConstants.appColor, foregroundColor: Colors.white,
           scrolledUnderElevation: 0,
           title : const Text("Favourite") ,
           centerTitle: true,

         ),

        body: BlocBuilder<FavouriteCubit , FavouriteStates>(

          builder: (context , state) {
            if (state is GetFavouriteStateSuccess){

              return RefreshIndicator(
                color: AppConstants.appColor,
                onRefresh: _handleRefresh ,
                child: ListView.builder(itemCount: state.favourites.length,
                    itemBuilder: (context , index)=> ProductItemVerticalView(
                      favourite: state.favourites[index],
                    )),
              ) ;
            }else if (state is GetFavouriteStateFailure){
              return Center(child:  Text(state.errorMsg),) ;
            }else{
              return const Center( child:  CircularProgressIndicator(),) ;
            }


          }
        ),
    );
  }

  Future<void> _handleRefresh() async {

    setState(() {
 BlocProvider.of<FavouriteCubit>(context).fetchFavourite() ;

    });
  }
}
