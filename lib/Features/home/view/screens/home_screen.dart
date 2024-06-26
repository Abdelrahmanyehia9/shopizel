import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppizel/Features/Auth/controller/login_cubit.dart';
import 'package:shoppizel/Features/Auth/view/screens/login_screen.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/view/screens/favourite_screen.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import '../widgets/home/home_body.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: homeAppBar(context),
      drawer: Drawer(
        child: ListView(
          children: [
          DrawerHeader(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage(
                      AppConstants.bgPatternAuthContainer,
                    ),
                    fit: BoxFit.cover)),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              CircleAvatar(
              radius: 36,
              backgroundColor: AppConstants.appColor,
            ),
            Text(
             _auth.currentUser!.displayName??"guest"
            , style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            _auth.currentUser!.email!,
            style: TextStyle(
                color: AppConstants.appColor, fontSize: 10),
          )
          ],
        ),
      ),
    ),
    const SizedBox(
    height: 24,
    ),
    ///profile
    InkWell(
    onTap: () {
    BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
    Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const FavouriteScreen()));
    },
    child: const ListTile(
    leading: Icon(FontAwesomeIcons.solidUser),
    title: Text("Profile"),
    ),
    ),
    /// favourite
    InkWell(
    onTap: () {
    BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const FavouriteScreen()));
    },
    child: const ListTile(
    leading: Icon(FontAwesomeIcons.solidHeart),
    title: Text("Favourite"),
    ),
    ),
    ///orders
    InkWell(
    onTap: () {
    BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const FavouriteScreen()));
    },
    child: const ListTile(
    leading: Icon(FontAwesomeIcons.receipt),
    title: Text("My orders"),
    ),
    ),
    /// promo codes
    InkWell(
    onTap: () {
    BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const FavouriteScreen()));
    },
    child: const ListTile(
    leading: FaIcon(FontAwesomeIcons.gift),
    title: Text("Promo Codes"),
    ),
    ),
    ///support
    InkWell(
    onTap: () {
    BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const FavouriteScreen()));
    },
    child: const ListTile(
    leading: Icon(FontAwesomeIcons.solidMessage),
    title: Text("Support"),
    ),
    ),
    ///setting
    InkWell(
    onTap: () {
    BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const FavouriteScreen()));
    },
    child: const ListTile(
    leading: Icon(Icons.settings),
    title: Text("Settings"),
    ),
    ),
    ///FAQs
    InkWell(
    onTap: () {
    BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const FavouriteScreen()));
    },
    child: const ListTile(
    leading: Icon(FontAwesomeIcons.solidCircleQuestion),
    title: Text("FAQs"),
    ),
    ),
    const SizedBox(
    height: 24,
    ),
    ///Logout
    InkWell(

    onTap: () {

    if(_auth.currentUser!= null){
    print(_auth.currentUser!.email) ;
    try{
    Navigator.pop(context) ;
    BlocProvider.of<LoginCubit>(context).signOut() ;
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
    (route) => false, // Replace false with your condition to stop removing routes
    ); }catch(e){
    print(e.toString()) ;
    }


    }else{
    }

    },
    child: const ListTile(
    leading: Icon(FontAwesomeIcons.signOut),
    title: Text("Log out"),
    ),
    ),
    ],
    ),
    ),
    body: const HomeBody());
  }

  /// appbar of home
  PreferredSizeWidget homeAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DELIVER TO',
            style: TextStyle(
                color: AppConstants.appColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'haram , giza',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: SvgPicture.asset(
              "assets/images/Menu.svg",
            )),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              SvgPicture.asset(
                "assets/images/Ellipse 1294.svg",
                fit: BoxFit.cover,
              ),
              const CircleAvatar(
                backgroundColor: AppConstants.appColor,
                radius: 12,
                child: Text(
                  "2",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppConstants.fontFamily),
                ),
              ),
            ],
          ),
        )
      ],
      leadingWidth: screenWidth(context) * 0.2,
    );
  }
}
