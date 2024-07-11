import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shoppizel/Features/rate/controller/rate_cubit.dart';
import 'package:shoppizel/Features/rate/controller/rate_state.dart';
import 'package:shoppizel/Features/rate/data/rate_model.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../../../shimmer/rates_loading.dart';

class MyRates extends StatefulWidget {
  const MyRates({super.key});

  @override
  State<MyRates> createState() => _MyRatesState();
}

class _MyRatesState extends State<MyRates> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RateCubit>(context).getMyRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("my rates"),
      ),
      body: BlocBuilder<RateCubit, RateState>(
        builder: (context, state) {
          if (state is GetAllRatesSuccess) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: ListView.builder(
                  itemCount: state.rates.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: rateItem(context, state.rates[index]),
                      )),
            );
          } else if (state is GetAllRatesLoading) {
            return const RatesLoading() ;
          } else {
            return const Center(child: Text("Oops there was an error "));
          }
        },
      ),
    );
  }

  Widget rateItem(context, RateModel rate) => Container(
        width: double.infinity,
        height: screenHeight(context) * 0.15,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight(context) * .15,
              width: screenWidth(context) * 0.25,
              child: Image.network(
                rate.product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      rate.product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppConstants.appColor),
                    ),
                  ),
                  Text(
                    "Store: ${rate.product.madeBy}",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingStars(
                    value: rate.rateCount.toDouble(),
                    starColor: Colors.amber,
                    starSize: 12,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    "'${rate.desc}'",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Spacer(),
                ],
              ),
            ) ,
          ],
        ),
      );
}
