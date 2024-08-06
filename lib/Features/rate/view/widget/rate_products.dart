import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shoppizel/Features/home/view/screens/home_screen.dart';
import 'package:shoppizel/Features/order/controller/order_cubit.dart';
import 'package:shoppizel/Features/profile/controller/profile_cubit.dart';
import 'package:shoppizel/Features/rate/controller/rate_cubit.dart';
import 'package:shoppizel/Features/rate/controller/rate_state.dart';
import 'package:shoppizel/Features/rate/data/rate_model.dart';
import 'package:shoppizel/Features/rate/view/screen/my_rates.dart';
import 'package:shoppizel/Features/rate/view/widget/description_rate.dart';
import 'package:shoppizel/Features/rate/view/widget/product_rating_stars.dart';
import 'package:shoppizel/core/widgets/snackbars.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import '../../../Auth/data/model/user_model.dart';
import '../../../cart/data/model/cart_model.dart';

class RateProducts extends StatefulWidget {

  final List<CartModel> products;
  final String orderId;

  final String rateBy;

  const RateProducts(
      {super.key,
      required this.rateBy,
      required this.products,
      required this.orderId});

  @override
  State<RateProducts> createState() => _RateProductsState();
}

class _RateProductsState extends State<RateProducts> {
  double starts  = 3 ;
  List<TextEditingController> controllers = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          decoration:
              const BoxDecoration(gradient: AppConstants.circularGradient),
          height: screenHeight(context) * .62,
          width: screenWidth(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) {
                        for (int i = 0; i < widget.products.length; i++) {
                          controllers.add(TextEditingController());
                        }
                        return rateItem(context, widget.products[index],
                            controllers[index]);
                      }),
                )),
                BlocConsumer<RateCubit, RateState>(
                  listener: (context, state) {
                    if (state is AddRateSuccess) {
                      BlocProvider.of<OrderCubit>(context)
                          .repo
                          .markOrderAsRated(widget.orderId)
                          .whenComplete(() {
                        BlocProvider.of<OrderCubit>(context)
                            .getOrders()
                            .whenComplete(() {
                          Navigator.pop(context);
                          SnackBars.customSnackBar(
                              context: context,
                              desc: "Your rate has been added",
                              tittle: "Great",
                              type: AnimatedSnackBarType.success);
                        });
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AddRateLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: PrimaryButton(
                          label: "rate",
                          color: Colors.white,
                          onTap: () async{
                            UserModel  user = await BlocProvider.of<ProfileCubit>(context).repo.getProfileInfo() ;
                            List<RateModel> rates = [];
                            for (int i = 0; i < widget.products.length; i++) {
                              RateModel model = RateModel(
                                dateRates: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()) ,
                                rateBy: user.uid,
                                product: widget.products[i],
                                desc: controllers[i].text,
                                rateCount: starts.floor().toInt(),
                              );
                              rates.add(model);
                            }
                            BlocProvider.of<RateCubit>(context)
                                .addNewRate(rates).whenComplete((){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const HomeScreen() )  , (route)=>false)  ;
                            });
                          },
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget rateItem(context, CartModel model, TextEditingController controller) =>
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: screenHeight(context) * 0.25,
                  width: screenWidth(context) * .5,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: model.imageUrl,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.name,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
               ProductRatingStars(
                rateCount: (rate){
               starts = rate??3 ;
                },
              ),
              DescriptionRate(
                controller: controller,
              )
            ],
          ));
}
