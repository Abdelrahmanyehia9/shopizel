import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../cart/controller/cart_cubit.dart';
import '../../../../cart/controller/cart_state.dart';
import '../../../../cart/view/screen/cart_screen.dart';
import 'my_location.dart';

class HomeAppBar extends StatelessWidget {
  final bool? isHome ;
  const HomeAppBar({super.key , this.isHome});

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      foregroundColor: Colors.black,
      expandedHeight: isHome != null ?  screenHeight(context) * .32:null,
      scrolledUnderElevation: 0,
      flexibleSpace: isHome != null ? FlexibleSpaceBar(
        background: Container(
          decoration:
          const BoxDecoration(gradient: AppConstants.circularGradient),
          padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top + 12,
              right: screenWidth(context) * .05,
              left: screenWidth(context) * .05),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sale 40% ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                      width: screenWidth(context) * 0.45,
                      child: Text(
                        "save 40% on first order use code 'FIRST40' ",
                        style: TextStyle(
                            color: Colors.grey.shade100, fontSize: 14),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: const Text(
                        "Use Now",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                  width: screenWidth(context) * .45,
                  height: screenHeight(context) * .3,
                  child: Image.asset(
                    "assets/images/pngwing.com (36).png",
                    fit: BoxFit.fitHeight,
                  ))
            ],
          ),
        ),
      ) :null,
      backgroundColor: const Color(0xffECF0F4),
      centerTitle: false,
      floating: true,
      snap: true,
      pinned: true,
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DELIVER TO',
            style: TextStyle(
                color: Colors.teal,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          MyLocation()
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: InkWell(
            onTap: () {
              BlocProvider.of<CartCubit>(context).fetchCartProducts();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CartScreen()));
            },
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                SvgPicture.asset(
                  "assets/images/Ellipse 1294.svg",
                  fit: BoxFit.cover,
                ),
                BlocBuilder<CartCubit, CartStates>(builder: (context, state) {
                  if (state is CartStateSuccess) {
                    return CircleAvatar(
                      backgroundColor: AppConstants.secondColor,
                      radius: 12,
                      child: Text(
                        state.cartCount.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    );
                  } else if (state is CartStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox();
                  }
                }),
              ],
            ),
          ),
        )
      ],
      leadingWidth: screenWidth(context) * 0.2,
    );
  }
}
