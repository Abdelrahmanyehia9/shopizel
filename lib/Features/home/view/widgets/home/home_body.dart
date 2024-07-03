import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/controllers/home_states.dart';
import 'package:shoppizel/Features/home/view/screens/all_categories.dart';
import 'package:shoppizel/Features/home/view/screens/all_stores.dart';
import 'package:shoppizel/Features/home/view/widgets/home/category_list.dart';
import 'package:shoppizel/Features/home/view/widgets/home/search_textfield.dart';
import 'package:shoppizel/core/utils/searching.dart';
import 'package:shoppizel/core/widgets/offer_card.dart';
import 'package:shoppizel/core/widgets/see_all.dart';
import 'package:shoppizel/Features/home/view/widgets/home/stores_list.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../../../../core/widgets/loading_failure.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../data/model/store_model.dart';

class HomeBody extends StatelessWidget {

  /// offer of the week
  HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      if (state is HomeStateSuccess) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// space
              SizedBox(
                height: screenHeight(context) * 0.035,
              ),

              ///greeting
              greetingText(
                  name: FirebaseAuth.instance.currentUser?.displayName),
              FanCarouselImageSlider.sliderType1(
                imagesLink: const [
                  "https://akns-images.eonline.com/eol_images/Entire_Site/2022528/rs_1024x759-220628162412-E-Comm.jpg?fit=around%7C1024:759&output-quality=90&crop=1024:759;center,top",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHJWjElfdcUgw4mqQUQeDTNpy9gE1kCxu5Qw&s",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnQ-agD00Mjm9KfLeOljh7wUT4SQRObPcgJw&s",
                ],
                showIndicator: false,
                turns: 100,
                autoPlayInterval: const Duration(seconds: 10),
                imageRadius: 12,
                initalPageIndex: 0,
                slideViewportFraction: 1,
                isAssets: false,
                isClickable: false,
                autoPlay: true,
                sliderHeight: screenHeight(context) * 0.27,
                sideItemsShadow: const [],
                currentItemShadow: const [],
                expandedImageFitMode: BoxFit.cover,
              ),

              ///search product
              /// offer of the week in database
              SeeAll(
                tittle: "All Category",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              AllCategories(categories: state.categories)));
                },
              ),

              /// category List (men -women - jewellery - kids)
              CategoryList(
                categories: state.categories.reversed.toList(),
              ),
              SeeAll(
                tittle: "Open Stores",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AllStores(stores: state.stores)));
                },
              ),
              StoresList(stores: state.stores)
            ],
          ),
        );
      } else if (state is HomeStateFailure) {
        return const LoadingFailure();
      } else {
        return const HomeLoadingShimmer();
      }
    });
  }

  Widget greetingText({String? name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
              text: name == null ? "Guest" : name.split(" ").first,
              style: const TextStyle(
                fontSize: 15,
              )),
          const TextSpan(text: ', ', style: TextStyle(fontSize: 15)),
          const TextSpan(
              text: 'Good Afternoon!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ], text: "Hey ", style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
