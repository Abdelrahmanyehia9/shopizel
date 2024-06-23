import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/controllers/home_states.dart';
import 'package:shoppizel/Features/home/view/widgets/home/category_list.dart';
import 'package:shoppizel/Features/home/view/widgets/home/search_textfield.dart';
import 'package:shoppizel/core/widgets/offer_card.dart';
import 'package:shoppizel/core/widgets/see_all.dart';
import 'package:shoppizel/Features/home/view/widgets/home/stores_list.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../../../../core/widgets/loading_failure.dart';

class HomeBody extends StatelessWidget {

  /// offer of the week
  const HomeBody({super.key});

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
              greetingText(),
              const SearchTextField(),

              ///search product
               /// offer of the week in database
              FanCarouselImageSlider.sliderType1(

                imagesLink: const ["https://newgirlsfashion.com/wp-content/uploads/2022/11/Kayseria-Featured-Image.jpg" , "https://wwwkcmpd.files.wordpress.com/2019/07/b1g1_desktop_banner_new.jpg" , "https://img.ltwebstatic.com/images3_ccc/2023/09/24/c6/169552199340d5f8b9560c03132bc7f1234d6d385e_thumbnail_912x.webp"],
                indicatorDeactiveColor: Colors.transparent,
autoPlayInterval: const Duration(seconds: 5),
showIndicator: false,
                isClickable: false,
                imageRadius: 0,
                initalPageIndex: 0,
                slideViewportFraction: 1.2,
                isAssets: false,
                autoPlay: true,
                sliderHeight: screenHeight(context)*0.3,
                sideItemsShadow: const [],
                currentItemShadow: const [],
                expandedImageFitMode: BoxFit.cover,
              ),


              const SeeAll(
                tittle: "All Category",
              ),

              /// category List (men -women - jewellery - kids)
              CategoryList(
                categories: state.categories.reversed.toList(),
              ),
              const SeeAll(
                tittle: "Open Stores",
              ),

              StoresList(stores: state.stores)
            ],
          ),
        );
      } else if (state is HomeStateFailure) {
        print(state.errorMessage);
        return const LoadingFailure();
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget greetingText({String? name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text.rich(
        TextSpan(
            children: [
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
