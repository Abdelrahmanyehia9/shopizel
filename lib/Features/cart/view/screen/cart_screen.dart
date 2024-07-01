import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoppizel/Features/cart/controller/cart_cubit.dart';
import 'package:shoppizel/Features/cart/controller/cart_state.dart';
import 'package:shoppizel/Features/cart/data/repository/cart_repo.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/widgets/loading_failure.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../../home/view/screens/home_screen.dart';
import '../../data/model/cart_model.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            splashColor: Colors.grey.withOpacity(0.5),
              onTap: ()async{

            await CartRepo().getCartEmpty().whenComplete((){
                  BlocProvider.of<CartCubit>(context).fetchCartProducts();
                }) ;


          },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: const Icon(Icons.delete),
              )) ,

        ],
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
                double totalPriceBeforeSale = state.cartProducts.fold(
                    0.0,
                    (sum, item) =>
                        sum + double.parse(item.price) * item.quantity);
                double totalPriceAfterSale = state.cartProducts.fold(
                    0.0,
                    (sum, item) =>
                        sum +
                        (double.parse(item.price) *
                            item.quantity *
                            (0.99999 - double.parse(item.sale) / 100.0)));

                if (state.cartProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight(context) * .085,
                        ),
                        SizedBox(
                            width: screenWidth(context) * .6,
                            height: screenHeight(context) * .35,
                            child: Image.asset(
                              "assets/images/pngwing.com (34).png",
                              fit: BoxFit.cover,
                            )),
                        const Text(
                          "You Don't Have Any product In Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()));
                          },
                          child: Container(
                              width: screenWidth(context) * .6,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppConstants.appColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                  child: Text(
                                "Browse Products",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))),
                        )
                      ],
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight(context) * .75,
                        child: ListView.builder(
                            itemCount: state.stores.toSet().toList().length,
                            itemBuilder: (context, index) => storeProducts(
                                storeName: state.stores[index],
                                items: BlocProvider.of<CartCubit>(context)
                                    .getProductByStore(state.stores[index],
                                        state.cartProducts),
                                context: context)),
                      ),

                      ///checkout
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppConstants.appColor,
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                const Icon(
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
                }
              } else if (state is CartStateFailure) {
                return const LoadingFailure();
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppConstants.appColor,
                ));
              }
            },
          ),
        ),
      ),
    );
  }

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
              itemBuilder: (context, index) => Slidable(
                key: ValueKey(
                  items[index].productId.toString() +
                      items[index].size +
                      items[index].color,
                ),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(
                    // Handle onDismissed action when swiped
                    onDismissed: () async {
                      await CartRepo().removeFromCart(items[index]).whenComplete((){
                        BlocProvider.of<CartCubit>(context).fetchCartProducts();

                      });

                      setState(() {
                        items.removeAt(index);
                      });
                    },
                  ),
                  children: [
                    // Swipe action button
                    SlidableAction(
                      spacing: 0,
                      onPressed: (val) async {
                        await CartRepo().removeFromCart(items[index]).whenComplete((){
                          BlocProvider.of<CartCubit>(context).fetchCartProducts();

                        });

                        setState(() {
                          items.removeAt(index);
                        });
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: CartItem(model: items[index]),
              )
          )
        ],
      );
}
