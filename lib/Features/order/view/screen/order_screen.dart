import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoppizel/Features/cart/controller/cart_cubit.dart';
import 'package:shoppizel/Features/cart/data/repository/cart_repo.dart';
import 'package:shoppizel/Features/cart/view/widgets/cart_item.dart';
import 'package:shoppizel/Features/order/data/order_fees.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../location/controller/location_cubit.dart';
import '../../../location/controller/location_states.dart';
import '../../../payment/view/screen/choose_payment_method.dart';
import '../widget/checkout_button.dart';
import '../widget/delivery_time.dart';
import '../widget/order_fees.dart';
import '../widget/shipping_address.dart';

class OrderScreen extends StatefulWidget {
  final List<CartModel> products;
  const OrderScreen({super.key, required this.products});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  String? orderFees ;
  final ScrollController _scrollController = ScrollController();
  bool? error;
  bool isProcessing = false;

  void _onAdd(int index) async {
    if (isProcessing) return;
    setState(() {
      isProcessing = true;
    });
    await BlocProvider.of<CartCubit>(context)
        .cartRepo
        .increaseAndDecreaseQuantity(widget.products[index], true);
    setState(() {
      widget.products[index].quantity++;

      isProcessing = false;
    });
  }
  void _onMinus(int index) async {
    if (isProcessing || widget.products[index].quantity <= 1) return;
    setState(() {
      isProcessing = true;
    });
    await BlocProvider.of<CartCubit>(context)
        .cartRepo
        .increaseAndDecreaseQuantity(widget.products[index], false);
    setState(() {
      widget.products[index].quantity--;
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isProcessing,
        color: Colors.black ,
        progressIndicator: const CircularProgressIndicator(color: AppConstants.appColor,),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShippingAddress(error: error),
                const DeliveryTime(time: "3 Days"),
                const Padding(
                  padding: EdgeInsets.only(top: 18.0, right: 4, left: 4),
                  child: Text(
                    "Shopping Cart",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppConstants.appColor),
                  ),
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      removeItemFromCart: () async{
                        if(widget.products.length>1){

                            await BlocProvider.of<CartCubit>(context).cartRepo.removeFromCart(widget.products[index]).whenComplete(
                                  () {
                                BlocProvider.of<CartCubit>(context)
                                    .fetchCartProducts();
                              },
                            );

                            setState(() {
                              widget.products.removeAt(index);
                            });

                        }

                      },
                      model: widget.products[index],
                      isOrder: true,
                      onAdd: () => _onAdd(index),
                      onMinus: () => _onMinus(index),
                    );
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text(
                    "Have a Gift Cart",
                    style: TextStyle(fontSize: 18, color: AppConstants.appColor, fontWeight: FontWeight.bold),
                  ),
                ),
                OrderFees(
                  fees: (value){
                    orderFees = value  ;
                  },
                  price: widget.products.fold(
                    0.0,
                        (sum, item) => sum + double.parse(item.price) * item.quantity,
                  ),
                  discount: OrderFeesRepo.isThereDiscount(widget.products)
                      ? widget.products.fold(
                    0.0,
                        (sum, item) => sum! + double.parse(item.price) * item.quantity * (double.parse(item.sale)) / 100,
                  )
                      : null,
                  checkoutTapped: () {
                    LocationStates state = BlocProvider.of<LocationCubit>(context).state;
                    if (state is GetLocationsStateSuccess) {
                      if (state.selectedLocation == null) {
                        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
                        setState(() {
                          error = true;
                        });
                      } else {
                        print(orderFees) ;
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ChoosePaymentMethod(
                          fees: orderFees!.toString(),
                          locationModel: state.selectedLocation!,
                          cartModel: widget.products,
                        )));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

