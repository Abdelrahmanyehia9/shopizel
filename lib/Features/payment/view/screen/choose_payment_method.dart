import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppizel/Features/order/controller/order_cubit.dart';
import 'package:shoppizel/Features/order/controller/order_state.dart';
import 'package:shoppizel/Features/order/data/order_model.dart';
import 'package:shoppizel/Features/order/view/widget/delivery_time.dart';
import 'package:shoppizel/Features/payment/view/screen/order_confirmed.dart';
import 'package:shoppizel/Features/profile/controller/profile_cubit.dart';
import 'package:shoppizel/core/function/snackbars.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';

import '../../../Auth/data/model/user_model.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../location/data/model.dart';
import '../widget/payment_methods.dart';
import '../widget/select_delivery_time.dart';

class ChoosePaymentMethod extends StatelessWidget {
  final LocationModel locationModel;

  final List<CartModel> cartModel;

  final String? promo;

  ChoosePaymentMethod(
      {super.key, required this.locationModel, required this.cartModel, this.promo});

  final TextEditingController _notesController = TextEditingController();

  String selectedTime = "3 Days";
  String selectedPaymentMethod = "Cash on delivery";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding (
                padding: EdgeInsets.only(top: 18.0, right: 4, left: 4),
                child: Text(
                  "Choose delivery Option",
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.appColor),
                ),

              ),
              SelectDeliveryTime(onSelected: (value) {
                selectedTime = value!;
              },),
              const Padding (
                padding: EdgeInsets.only(top: 18.0, right: 4, left: 4),
                child: Text(
                  "Choose payment option",
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.appColor),
                ),

              ),
              const SizedBox(height: 12,),
              PaymentMethods(onSelected: (val) {
                selectedPaymentMethod = val!;
              },),
              const Padding (
                padding: EdgeInsets.only(
                    top: 18.0, right: 4, left: 4, bottom: 8),
                child: Text(
                  "Notes on Delivery",
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.appColor),
                ),

              ),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 12),
                    hintText: "ex.Don't ring the bell",
                    border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none
                    )
                ),

              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: BlocConsumer<OrderCubit  , OrderState>(
                  listener: (context , state){
                    if (state is MakeOrderFailure){
                      SnackBars.customSnackBar(context: context, desc: "error in making order try again later", tittle: "failed", type: AnimatedSnackBarType.error) ;
                    }else if (state is MakeOrderSuccess){
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>  const OrderConfirmed()  )) ;


                    }


                  },
                  builder: (context  , state){
                    if (state is MakeOrderLoading){
                      return const Center(child: CircularProgressIndicator(),) ;
                    }
                    else{
                      return   PrimaryButton(label: "Pay", onTap: () async{
                    UserModel profile = await BlocProvider.of<ProfileCubit>(context).repo.getProfileInfo() ;
                    OrderModel order = OrderModel(
                    orderId: "",
                    dateOfOrder: DateTime.now().toString(),
                    paymentMethod: selectedPaymentMethod,
                    products: cartModel,
                    userModel: profile ,
                    orderStatus: "Accepted",
                    location: locationModel,
                    time: selectedTime,
                    notes: _notesController.text==""?null: _notesController.text.trim()) ;
                    context.read<OrderCubit>().makeAnOrder(order);
                    },) ;
                    }
                  },

                ),
              )
            ],),
        ),
      ),
    );
  }


}


