import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/rate/controller/rate_cubit.dart';
import 'package:shoppizel/Features/rate/controller/rate_state.dart';
import 'package:shoppizel/Features/rate/data/rate_model.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:expandable/expandable.dart';

import '../../../Auth/data/model/user_model.dart';

class ProductRate extends StatefulWidget {
  final ProductModel model;

  const ProductRate({super.key, required this.model});

  @override
  State<ProductRate> createState() => _ProductRateState();
}

class _ProductRateState extends State<ProductRate> {
  @override
  void initState() {
    BlocProvider.of<RateCubit>(context).getProductRate(widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RateCubit, RateState>(
      builder: (context, state) {
        if (state is GetProductRateSuccess) {
          int count = state.rates.isEmpty ? 1:state.rates.length ;
          int rateSum = 0;
          for (int i = 0; i < state.rates.length; i++) {
            rateSum += state.rates[i].rateCount;
          }
          print(rateSum.toString) ;
          return ExpandablePanel(
              theme: const ExpandableThemeData(
                tapHeaderToExpand: true,
                iconPadding: EdgeInsets.zero,
                hasIcon: true,
              ),
              collapsed: const SizedBox(),
              header: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    (rateSum / count).toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade700,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "(${state.rates.length} Reviews)",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              expanded: state.rates.isNotEmpty
                  ? SizedBox(
                      height: screenHeight(context) * 0.45,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.builder(
                          itemCount: state.rates.length,
                          itemBuilder: (context, index) {
                            RateModel rate = state.rates[index];

                            // Use FutureBuilder to asynchronously fetch user data
                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection(FirebaseConstant.usersCollection)
                                  .doc(rate.rateBy)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                }

                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return Center(
                                    child: Text('User not found'),
                                  );
                                }

                                // Data retrieved successfully
                                Map<String, dynamic> userData = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                UserModel user = UserModel.fromJson(userData);

                                // Call rateItem to build UI for each rate item
                                return rateItem(context, rate, user);
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("No rates right now"),
                      ),
                    )
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget rateItem(BuildContext context, RateModel rate, UserModel user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppConstants.appColor,
              backgroundImage: user.profilePic == null
                  ? const AssetImage("assets/images/avatar.png")
                  : CachedNetworkImageProvider(user.profilePic!),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username ?? "Guest",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingStars(
                    value: rate.rateCount.toDouble(),
                    starSize: 16,
                    valueLabelTextStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rate.desc,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
