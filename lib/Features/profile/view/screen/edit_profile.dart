import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/view/screens/home_screen.dart';
import 'package:shoppizel/Features/profile/controller/profile_cubit.dart';
import 'package:shoppizel/Features/profile/controller/profile_state.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';

import '../../../../core/function/snackbars.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../Auth/data/model/user_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final TextEditingController _number = TextEditingController();

  final TextEditingController _name = TextEditingController();

  @override
  void initState() {
    _name.text = widget.userModel.username ?? "Guest";
    _number.text = widget.userModel.number ?? "0123456789";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight(context),
        decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              
                image: AssetImage(
                  
                  AppConstants.bgPatternAuthContainer,
                ),
                
                fit: BoxFit.cover)),
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight(context)*0.125,) ,
              const Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider("https://i.postimg.cc/5tdvGxX2/117891559-1259928357686178-3630984762144176343-n.jpg")
                        ,  radius: 64,
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
              const SizedBox(
                height: 18,
              ),
              fieldOfAddress(controller: _name, label: 'Username'),
              fieldOfAddress(controller: _number, label: 'Phone number'),
              SizedBox(
                height: screenHeight(context) * 0.025,
              ),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is EditProfileInfoSuccess) {
                    SnackBars.customSnackBar(
                        context: context,
                        desc: "profile updated Successfully",
                        tittle: "Great",
                        type: AnimatedSnackBarType.success);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomeScreen())) ;
                  }

                },
                builder: (context, state) {
                  if (state is EditProfileInfoLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return PrimaryButton(
                      label: "Submit",
                      onTap: () async {
                        UserModel user = UserModel(uid: FirebaseAuth.instance.currentUser!.uid, email: FirebaseAuth.instance.currentUser!.email! , number: _number.text.trim() , username: _name.text.trim()) ;
                        await BlocProvider.of<ProfileCubit>(context)
                            .editProfile(user).whenComplete((){
                              BlocProvider.of<ProfileCubit>(context).fetchProfile() ;
                        });
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldOfAddress(
          {required String label,
          String? hint,
          required TextEditingController controller,
          TextInputType? inputType}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: inputType ?? TextInputType.text,
              controller: controller,
              decoration: InputDecoration(
                  filled: true,
                  hintText: hint ?? "",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none)),
            )
          ],
        ),
      );
}
