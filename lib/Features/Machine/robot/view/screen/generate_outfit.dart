import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shoppizel/Features/Auth/view/widgets/auth_textfeild.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/view/search_by_photo_screen.dart';
import 'package:shoppizel/Features/Machine/robot/controller/generate_outfit_cubit.dart';
import 'package:shoppizel/Features/Machine/robot/controller/generate_outfit_state.dart';
import 'package:shoppizel/Features/Machine/robot/data/model/generate_outfit_model.dart';
import 'package:shoppizel/core/service/ImageHelper.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';

import '../../../../../core/widgets/snackbars.dart';
import '../../../../../core/utils/app_constants.dart';

class GenerateOutfit extends StatefulWidget {
  const GenerateOutfit({super.key});

  @override
  State<GenerateOutfit> createState() => _GenerateOutfitState();
}

class _GenerateOutfitState extends State<GenerateOutfit> {
  final TextEditingController _controller = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: BlocConsumer<GenerateOutfitCubit , GenerateOutfitState>(
            listener: (context , state){
              if(state is GenerateOutfitStateFailure){
                SnackBars.customSnackBar(context: context, desc: state.error, tittle: "error", type: AnimatedSnackBarType.error) ;
              }
            },
            builder: (context  , state) {
              if (state is GenerateOutfitStateSuccess){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          SizedBox(
                              height: screenHeight(context) * 0.55,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                fit: BoxFit.fitHeight, imageUrl: state.model.output!.last,
                                placeholder: (context  , url)=>const Center(child: CircularProgressIndicator()),

                              )),
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                  AppConstants.appColor.withOpacity(0.1),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ) ,
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: Container(
                              width: 60,height: 80,

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.white,
                                  border: Border.all(color: AppConstants.appColor , width: 2),
                                  image: DecorationImage(image: NetworkImage("https://i.postimg.cc/JnBRzpzd/istockphoto-523150985-612x612.jpg"))
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: SizedBox(
                        child: Column(
                          children: [

                            const SizedBox(height: 16,) ,
                            Text("Created at : ${DateFormat("dd-mm-yyyy hh:mm a").format(DateTime.parse(state.model.createdAt!))}" , style: TextStyle(color: Colors.grey),) ,
                            Text("Created at : ${DateFormat("dd-mm-yyyy hh:mm a").format(DateTime.parse(state.model.completedAt!))}" , style: TextStyle(color: Colors.grey),) ,
                            Text("predicted Time : ${state.model.metrics!.predictTime!.toStringAsFixed(2)} s" , style: TextStyle(color: Colors.grey),) ,
                            const SizedBox(height: 16,) ,

                          ],
                        ),
                      ),
                    ) ,
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0 , bottom: 8),
                      child: SizedBox(
                          width: screenWidth(context) * .9,
                          child: PrimaryButton(
                            label: "Show Similar",
                            onTap: () async{
                              File image = await ImageHelper.downloadImage(state.model.output!.last, "downloaded_image.jpg") ;
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchByPhotoScreen( photo: image,  ))) ;
                              
                              
                              
                            },
                          )),
                    ) ,
                    Padding(
                      padding: const EdgeInsets.only(top: 0 , bottom: 16),
                      child: SizedBox(
                          width: screenWidth(context) * .9,
                          child: PrimaryButton(
                            label: "Reset",
                            onTap: () {
                              BlocProvider.of<GenerateOutfitCubit>(context).returnToDefult() ;
                            },
                          )),
                    )

                  ],
                ) ;
              }else if (state is GenerateOutfitStateLoading){
                return const Center(child: LinearProgressIndicator(color: AppConstants.appColor,),) ;
              }else{
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [

                          SizedBox(
                              height: screenHeight(context) * 0.55,
                              width: double.infinity,
                              child: Image.asset(
                                "assets/images/man-model.png",
                                fit: BoxFit.fitHeight,
                              )),
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                  AppConstants.appColor.withOpacity(0.1),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Where do you want to change  ",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    ToggleButtons(
                      borderColor: AppConstants.appColor,
                      selectedBorderColor: AppConstants.appColor,
                      isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                      onPressed: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      selectedColor: Colors.white,
                      fillColor: AppConstants.appColor,
                      color: AppConstants.appColor,
                      children: <Widget>[
                        SizedBox(
                          width: screenWidth(context) * .45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset("assets/images/shirt.svg")),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text('Top Wear'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context) * .45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset("assets/images/pants.svg")),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text('Bottom Wear'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Tell us about ${_selectedIndex == 0 ? "Top" : "bottom"} do you want ",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                        width: screenWidth(context) * .9,
                        child: AuthTextField(
                            validator: (value) {
                              if (value == "") {
                                return "this field shouldn't be empty";
                              }
                            },
                            controller: _controller,
                            initialValue: "ex. ${_selectedIndex == 0 ?"black polo t-shirt" : "blue jeans pant"}")),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: SizedBox(
                          width: screenWidth(context) * .9,
                          child: PrimaryButton(
                            label: "Generate",
                            onTap: () {

                              if (globalKey.currentState!.validate()) {
                                Input input  = Input(image: "https://i.postimg.cc/JnBRzpzd/istockphoto-523150985-612x612.jpg" , prompt: _controller.text.trim() , clothing: _selectedIndex==0?"topwear":"bottomwear" ) ;
                                  BlocProvider.of<GenerateOutfitCubit>(context).generate(input) ;

                              }
                            },
                          )),
                    )
                  ],
                ) ;
              }




            },

          ),
        ),
      ),
    ));
  }
}
