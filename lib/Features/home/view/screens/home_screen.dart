import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/view/search_by_photo_screen.dart';
import 'package:shoppizel/Features/cart/controller/cart_cubit.dart';
import 'package:shoppizel/Features/location/controller/location_cubit.dart';
import 'package:shoppizel/Features/profile/view/screen/pick_image.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import '../../../Machine/robot/view/robot_view.dart';
import '../../../profile/controller/profile_cubit.dart';
import '../../controllers/home_cubit.dart';
import '../widgets/bot.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/home_body.dart';
import '../widgets/home/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageSearch ;
bool visible = true ;
  int _bottomNavIndex = 0;

  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget>pages = [
    CustomScrollView(
      controller: ScrollController(),
      slivers: [
        const HomeAppBar(isHome: true,) ,
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const HomeBody()              ],
          ),
        ),
      ],
    ),
    const RobotScreen() ,
    const bot(text: "setting") ,
    const bot(text: "profile")

  ]  ;

  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).fetch();
    BlocProvider.of<CartCubit>(context).fetchCartProducts();
    BlocProvider.of<ProfileCubit>(context).fetchProfile();
    BlocProvider.of<LocationCubit>(context).getAllLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: visible,
        child: FloatingActionButton(
             tooltip: "Scan with photo",
          onPressed: () async{
            setState(() {
              visible = false ;
            });

          final  result = await  showModalBottomSheet(context: context, builder: (_)=> ChooseImagePicker(isSearching:true  , onSelected: (value){
              imageSearch = value ;
              if (imageSearch != null ){

                Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchByPhotoScreen(photo : imageSearch!)   )) ;
              }

            })  ) ;

          if(result == null ){
            setState(() {
              visible = true  ;
            });
          }
          },
          shape: const CircleBorder(),
          backgroundColor: AppConstants.appColor,
          child: const Icon(
            Icons.document_scanner_outlined,
            color: Colors.white,

          ),
        ),
      ),
      key: _scaffoldKey,
      drawer: HomeDrawer(),
      body: pages[_bottomNavIndex] ,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 24,
        inactiveColor: Colors.grey,
        activeColor: AppConstants.appColor,
        icons: const [
          Icons.home,
          Icons.face,
          Icons.settings,
          Icons.person,
        ],

        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }

}
