import 'package:flutter/material.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../data/order_model.dart';
import 'order_item.dart';

class MyOrdersView extends StatelessWidget {
  final List<OrderModel> orders;

  const MyOrdersView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context),
      width: screenWidth(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) => OrderItem(
                  orderModel: orders[index],
                )),
      ),
    );
  }
}
