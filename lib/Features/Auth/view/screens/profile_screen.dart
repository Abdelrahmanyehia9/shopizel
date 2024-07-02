import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppizel/Features/location/view/screen/saved_addresses.dart';
import 'package:shoppizel/core/utils/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      body: SingleChildScrollView(
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
              child: const Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1868"),
                            radius: 64,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 18,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              size: 14,
                              color: AppConstants.appColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "+20150164466",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    "email@yahoo.com",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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
