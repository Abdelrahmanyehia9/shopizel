import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_state.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/Favourite/view/widget/product_item_vertical_view.dart';
import 'package:shoppizel/Features/home/view/screens/all_categories.dart';
import 'package:shoppizel/Features/home/view/screens/home_screen.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

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
              if(state.favourites.isEmpty){

                return Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SizedBox(width: screenWidth(context) *.6,
                        height: screenHeight(context)*.35,
                        child: Image.asset("assets/images/Women Power - Mobile.png" , fit: BoxFit.cover,)) ,
                      const Text("You Don't Have Any product In Favourite" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14),),
                      const SizedBox(height: 12,) ,
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())) ;
                        },
                        child: Container(width: screenWidth(context)*.6 , height: 60  ,
                        child: const Center(child: Text("Browse Products" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                        decoration: BoxDecoration(
                          color: AppConstants.appColor ,

                          borderRadius: BorderRadius.circular(12) ,

                        )),
                      )

                  ],),
                );
              }else{
                return RefreshIndicator(
                  color: AppConstants.appColor,
                  onRefresh: _handleRefresh ,
                  child: ListView.builder(itemCount: state.favourites.length,
                      itemBuilder: (context , index)=> Slidable(
                        key: ValueKey(state.favourites[index].id),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () {
                            setState(() {
                              FavouriteRepo().removeFromFavourite(id: state.favourites[index].id) ;
                              state.favourites.removeAt(index) ;
                            });
                          }),
                          children:  [
                            SlidableAction(
                              spacing: 0,
                              onPressed: (context){
                                setState(() {
                                  FavouriteRepo().removeFromFavourite(id: state.favourites[index].id) ;
                                  state.favourites.removeAt(index) ;
                                });
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),



                        child: ProductItemVerticalView(
                          favourite: state.favourites[index],
                        ),
                      )),
                ) ;
              }


            }else if (state is GetFavouriteStateFailure){
              return Center(child:  Text(state.errorMsg),) ;
            }else{
              return const Center( child:  CircularProgressIndicator(color: AppConstants.appColor,),) ;
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



