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
import 'package:carousel_slider/carousel_slider.dart';

class HomeBody extends StatelessWidget {
  /// offer of the week
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      "https://i.postimg.cc/bwBbH0dj/19575339-331497697271041-6891568621659223354-o.jpg",
      "https://pbs.twimg.com/media/C0SShxrWIAEWsEA.jpg",
      "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/2bbcfa99737217.5ef9be3dbb9a9.jpg",
      "https://manage.babycouture.in/public/banners/banner_1631167643.jpg"
    ];
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
              SizedBox(height: 12,) ,
              CarouselSlider(
                options: CarouselOptions(
                  enlargeFactor: 0.2,
                  viewportFraction: 0.85,
                  enlargeCenterPage: true,
                  height: screenHeight(context) * 0.2,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: imgList
                    .map((item) => InkWell(
                  onTap:()async{
                  } ,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(item, fit: BoxFit.fill)),
                    ))
                    .toList(),
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
