import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/function/snackbars.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../Auth/controller/auth_cubit.dart';
import '../../../../Auth/data/model/user_model.dart';
import '../../../../Auth/view/screens/login_screen.dart';
import '../../../../Favourite/controller/favourite_cubit.dart';
import '../../../../Favourite/view/screens/favourite_screen.dart';
import '../../../../profile/controller/profile_cubit.dart';
import '../../../../profile/controller/profile_state.dart';
import '../../../../profile/view/screen/profile_screen.dart';

class HomeDrawer extends StatelessWidget {
  UserModel userModel ;

  HomeDrawer({super.key , required this.userModel});
  final FirebaseAuth _auth = FirebaseAuth.instance ;
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          ///logo
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context , state) {
              if (state is ProfileInfoSuccess){
                userModel = state.profileInfo ;
                return DrawerHeader(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 36,
                          backgroundColor: AppConstants.appColor,
                          backgroundImage: CachedNetworkImageProvider("https://i.postimg.cc/5tdvGxX2/117891559-1259928357686178-3630984762144176343-n.jpg"),
                        ),
                        SizedBox(width: screenWidth(context)*0.65,
                          child: Text(
                            maxLines: 1 , overflow: TextOverflow.ellipsis ,
                            textAlign: TextAlign.center ,
                            state.profileInfo.username ?? "guest"
                            , style: const TextStyle(

                              color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          state.profileInfo.email ,
                          style: const TextStyle(
                              color: AppConstants.appColor, fontSize: 10),
                        ) ,
                        Text(
                          state.profileInfo.number??"0123456789",
                          style: const TextStyle(
                              color: AppConstants.appColor, fontSize: 8),
                        )

                      ],
                    ),
                  ),
                );


              }
              else if (state is ProfileInfoLoading){
                return DrawerHeader(
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
                      child: const Center(child: CircularProgressIndicator(color: Colors.white,),)
                  ),
                );
              }
              else{
                return DrawerHeader(
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
                    child: const Center(
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: AppConstants.appColor,
                      ),
                    ),
                  ),
                );
              }

            },

          ),
          const SizedBox(
            height: 24,
          ),

          ///profile
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) =>  ProfileScreen(
                userModel: userModel,
              )));
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
              Navigator.pop(context);
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

            },
            child: const ListTile(
              leading: FaIcon(FontAwesomeIcons.gift),
              title: Text("Promo Codes"),
            ),
          ),

          ///support
          InkWell(
            onTap: () {

            },
            child: const ListTile(
              leading: Icon(FontAwesomeIcons.solidMessage),
              title: Text("Support"),
            ),
          ),

          ///setting
          InkWell(
            onTap: () {

            },
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
          ),

          ///FAQs
          InkWell(
            onTap: () {
            },
            child: const ListTile(
              leading: Icon(FontAwesomeIcons.solidCircleQuestion),
              title: Text("FAQs"),
            ),
          ),
          const SizedBox(
            height: 18,
          ),

          ///Logout
          InkWell(

            onTap: () {
              if (_auth.currentUser != null) {
                try {
                  Navigator.pop(context);
                  BlocProvider.of<AuthCubit>(context).signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                        (
                        route) => false, // Replace false with your condition to stop removing routes
                  );
                } catch (e) {
                  SnackBars.customSnackBar(context: context, desc: "you should Sign In Before That", tittle: "Failed", type: AnimatedSnackBarType.error) ;
                }
              } else {}
            },
            child: const ListTile(
              leading: Icon(FontAwesomeIcons.arrowRightFromBracket),
              title: Text("Log out"),
            ),
          ),
        ],
      ),
    ) ;
  }
}
