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
import '../../../../loading.dart';

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
        return const HomeLoadingShimmer() ;
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
