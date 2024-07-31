import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Auth/data/model/user_model.dart';
import 'package:shoppizel/Features/Favourite/view/screens/favourite_screen.dart';
import 'package:shoppizel/Features/location/view/screen/saved_addresses.dart';
import 'package:shoppizel/Features/order/view/screen/my_orders.dart';
import 'package:shoppizel/Features/payment/view/screen/saved_card.dart';
import 'package:shoppizel/Features/profile/controller/profile_cubit.dart';
import 'package:shoppizel/Features/profile/view/screen/edit_profile.dart';
import 'package:shoppizel/Features/promo/view/screen/promo_code_screen.dart';
import 'package:shoppizel/Features/rate/view/screen/my_rates.dart';
import 'package:shoppizel/core/database/local/shared_prefrences.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../../../core/function/snackbars.dart';
import '../../../Auth/controller/auth_cubit.dart';
import '../../../Auth/view/screens/login_screen.dart';
import '../../../Favourite/controller/favourite_cubit.dart';

class ProfileScreen extends StatelessWidget {
   const ProfileScreen({super.key,  });

  @override
  Widget build(BuildContext context) {
    UserModel userModel = BlocProvider.of<ProfileCubit>(context).profile  ;
    return Scaffold(
      body: SingleChildScrollView
        (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(
                        AppConstants.bgPatternAuthContainer,
                      ),
                      fit: BoxFit.cover)),
              padding: const EdgeInsets.all(12),
              child:  Column(
                children: [
                  SizedBox(height: screenHeight(context)*0.075,) ,

                   Center(
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: AppConstants.appColor,
                        backgroundImage: userModel.profilePic !=null ? CachedNetworkImageProvider(userModel.profilePic! ,):  const AssetImage("assets/images/avatar.png" ,),
                          radius: 64,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    userModel.username??"Guest",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    userModel.number??"0123456789",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    userModel.email,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
        
            const SizedBox(
              height: 18,
            ),
        
            ///edit profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(

                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (_)=> EditProfile(userModel: userModel))) ;
                 },
                leading: CircleAvatar(
                    backgroundColor: AppConstants.appColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.person_outline,
                      size: 18,
                      color: AppConstants.appColor,
                    )),
                title: const Text("Edit Profile"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),
            /// favourite
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(
                onTap: (){
                  BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const FavouriteScreen()));
                },
                leading: CircleAvatar(
                    backgroundColor: AppConstants.appColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.favorite_outline,
                      size: 18,
                      color: AppConstants.appColor,
                    )),
                title: const Text("Favourites"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),

            /// Orders
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const MyOrders()));
                },
                leading: CircleAvatar(
                    backgroundColor: AppConstants.appColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.receipt_outlined ,
                      size: 18,
                      color: AppConstants.appColor,
                    )),
                title: const Text("My Orders"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),
            /// promo
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const PromoCodeScreen()));
                },
                leading: CircleAvatar(
                    backgroundColor: AppConstants.appColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.wallet_giftcard_outlined ,
                      size: 18,
                      color: AppConstants.appColor,
                    )),
                title: const Text("Vouchers"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),
            ///address
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const SavedAddresses()));
                },
                leading: CircleAvatar(
                    backgroundColor: AppConstants.appColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: AppConstants.appColor,
                    )),
                title: const Text("My Addresses"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),

            ///cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const SavedCard()));
                },
                leading: CircleAvatar(
                    backgroundColor: AppConstants.appColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.credit_card,
                      size: 18,
                      color: AppConstants.appColor,
                    )),
                title: const Text("My Cards"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),

            ///ratings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const MyRates())) ;
                },
                leading: CircleAvatar(
                    backgroundColor: Colors.yellow.shade800.withOpacity(0.1),
                    child: Icon(
                      Icons.star_rate,
                      size: 18,
                      color: Colors.yellow.shade800,
                    )),
                title: const Text("My Ratings"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),
        
            ///privacy
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: AppConstants.appColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.lock_outline,
                      size: 18,
                      color: AppConstants.appColor,
                    )),
                title: const Text("Privacy Policy"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),
        
            ///logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              child: ListTile(
                onTap: ()async{
                  if (FirebaseAuth.instance.currentUser != null) {

                      Navigator.pop(context);
                      BlocProvider.of<AuthCubit>(context).signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                            (
                            route) => false, // Replace false with your condition to stop removing routes
                      );
                      await SharedPreferenceHelper.setBool(SharedPreferenceHelper.isLoggingIn, false) ;


                  }
                },
                leading: CircleAvatar(
                    backgroundColor: AppConstants.appColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.logout_outlined,
                      size: 18,
                      color: AppConstants.appColor,
                    )),
                title: const Text("Log out"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppConstants.appColor,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
