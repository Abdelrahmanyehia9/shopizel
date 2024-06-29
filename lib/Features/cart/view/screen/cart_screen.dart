import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/cart/controller/cart_cubit.dart';
import 'package:shoppizel/Features/cart/controller/cart_state.dart';
import 'package:shoppizel/Features/cart/data/repository/cart_repo.dart';
import 'package:shoppizel/Features/home/data/repository/store_repo.dart';
import 'package:shoppizel/core/function/snackbars.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/widgets/loading_failure.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../data/model/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppConstants.appColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CartCubit, CartStates>(
            builder: (context, state) {
              if (state is CartStateSuccess) {
              double totalPriceBeforeSale =   state.cartProducts.fold(0.0, (sum, item) => sum + double.parse(item.price));
              double totalPriceAfterSale =   state.cartProducts.fold(0.0, (sum, item) => sum + (double.parse(item.price) * (0.99999 - double.parse(item.sale) / 100.0)));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.stores.toSet().toList().length,
                      itemBuilder: (context, index) => storeProducts(
                          storeName: state.stores[index],
                          items: BlocProvider.of<CartCubit>(context)
                              .getProductByStore(
                                  state.stores[index], state.cartProducts),
                          context: context)),
                  ///checkout
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppConstants.appColor,
                        borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.all(18),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Checkout",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              "${totalPriceAfterSale.toStringAsFixed(2)} EGP",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
              } else if (state is CartStateFailure) {
                return const LoadingFailure();
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget cartItem(BuildContext context, CartModel model) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: screenHeight(context) * .25,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: screenWidth(context) * .3,
                      height: screenHeight(context) * .2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(model.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth(context) * 0.4,
                              child: Text(
                                model.name,
                                maxLines: 2,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Size : ${model.size}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "quantity: ${model.quantity}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Color :",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      Color(int.parse(model.color)),
                                  radius: 6,
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            Text.rich(
                              TextSpan(
                                  text: model.sale != "0"
                                      ? (double.parse(model.price) *
                                              model.quantity *
                                              (0.99999 -
                                                  double.parse(model.sale) /
                                                      100.0))
                                          .toStringAsFixed(2)
                                          .split(".")
                                          .first
                                      : (double.parse(model.price) *
                                              model.quantity)
                                          .toStringAsFixed(0),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                    color: AppConstants.appColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          ".${(double.parse(model.price) * model.quantity * (0.99999 - double.parse(model.sale) / 100.0)).toStringAsFixed(2).split(".").last}",
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    const TextSpan(
                                      text: " EGP",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    TextSpan(
                                      text: model.sale != "0"
                                          ? " ${double.parse(model.price) * model.quantity}EGP"
                                          : "",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 9,
                                          decorationColor: Colors.grey),
                                    )
                                  ]),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            model.sale != "0"
                ? Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.appColor),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "${model.sale}% sale",
                        style: const TextStyle(
                            color: AppConstants.appColor, fontSize: 10),
                      ),
                    ),
                  )
                : const SizedBox(),
               Positioned(
                  right: 12,
                  bottom: 12,
                  child: InkWell(
                    onTap: (){
                                  CartRepo().removeFromCart(model) ;

                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        "Remove",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )




          ],
        ),
      );

  Widget storeProducts(
          {required String storeName,
          required List<CartModel> items,
          required BuildContext context}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              storeName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
              itemCount: items.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) => cartItem(context, items[index]))
        ],
      );
}
