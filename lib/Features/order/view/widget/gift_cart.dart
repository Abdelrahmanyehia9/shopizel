import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/order/controller/order_cubit.dart';
import 'package:shoppizel/Features/order/data/order_fees.dart';
import 'package:shoppizel/Features/promo/controller/promo_state.dart';
import 'package:shoppizel/Features/promo/data/promo_model.dart';
import 'package:shoppizel/Features/promo/controller/promo_cubit.dart';
import 'package:shoppizel/Features/promo/data/promo_code_repo.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';

class GiftCartTextField extends StatefulWidget {
  final String total;

  const GiftCartTextField({super.key, required this.total});

  @override
  State<GiftCartTextField> createState() => _GiftCartTextFieldState();
}

class _GiftCartTextFieldState extends State<GiftCartTextField> {
  final TextEditingController _controller = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromoCubit, PromoState>(
      builder: (context, state) {
        if (state is ApplyPromoFailure) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth(context) * .7,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 12),
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "apply here",
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: (){
                      BlocProvider.of<PromoCubit>(context).applyPromo(_controller.text.trim()) ;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth(context) * 0.25,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppConstants.gradient,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "Apply",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              )
            ],
          );
        } else if (state is ApplyPromoSuccess) {

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "You have Applied ${state.promoModel.code} Successfully",
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: InkWell(
                    onTap: () {
                      BlocProvider.of<PromoCubit>(context).removePromo() ;
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.green,
                      size: 18,
                    )),
              ),
            ],
          );
        } else if (state is ApplyPromoLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth(context) * .7,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 12),
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "apply here",
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<PromoCubit>(context)
                          .applyPromo(_controller.text.toLowerCase().trim());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth(context) * 0.25,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppConstants.gradient,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "Apply",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
