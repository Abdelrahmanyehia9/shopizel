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
              SizedBox(
                height: screenHeight(context) * 0.035,
              ),
              greetingText(),
              const SizedBox(
                height: 12,
              ),
              const SearchTextField(),
              offerCard3("https://newgirlsfashion.com/wp-content/uploads/2022/11/Kayseria-Featured-Image.jpg") ,
              const SizedBox(
                height: 12,
              ),
              const SeeAll(
                tittle: "All Category",
              ),
              const SizedBox(
                height: 6,
              ),
              CategoryList(
                categories: state.categories.reversed.toList(),
              ),
              const SeeAll(
                tittle: "Open Stores",
              ),
              const SizedBox(
                height: 16,
              ),
              StoresList(stores: state.stores , allProducts: state.products,)
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
