import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/view/screens/favourite_screen.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import '../widgets/home/home_body.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,

        appBar: homeAppBar(context),
        drawer: Drawer(
          child: ListView(
            children: [
              InkWell(
                onTap: (){
                  BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>FavouriteScreen())) ;
                },
                child: const ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text("Favourite"),
                ),
              )
            ],

          ),
        ),
        body: const HomeBody()
    );
  }
/// appbar of home
  PreferredSizeWidget homeAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DELIVER TO', style: TextStyle(color: AppConstants.btnColor,
              fontSize: 12,
              fontWeight: FontWeight.bold),),
          Text('haram , giza', style: TextStyle(fontSize: 14),),

        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: InkWell(onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
            child: SvgPicture.asset("assets/images/Menu.svg",)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Stack(

            alignment: AlignmentDirectional.topEnd,
            children: [


              SvgPicture.asset(
                "assets/images/Ellipse 1294.svg", fit: BoxFit.cover,),
              const CircleAvatar(
                backgroundColor: AppConstants.btnColor,
                radius: 12,
                child: Text("2", style: TextStyle(color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.fontFamily),),
              ),


            ],
          ),
        )
      ],
      leadingWidth: screenWidth(context) * 0.2,

    );
  }
}