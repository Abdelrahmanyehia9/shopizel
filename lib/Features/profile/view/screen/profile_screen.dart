import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/Auth/data/model/user_model.dart';
import 'package:shoppizel/Features/location/view/screen/saved_addresses.dart';
import 'package:shoppizel/Features/profile/view/screen/edit_profile.dart';
import 'package:shoppizel/core/utils/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel userModel ;
   ProfileScreen({super.key, required this.userModel });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white ,
        backgroundColor: AppConstants.appColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
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
                  const Center(
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider("https://i.postimg.cc/5tdvGxX2/117891559-1259928357686178-3630984762144176343-n.jpg")
                         , radius: 64,
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
                title: const Text("My Adresses"),
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
