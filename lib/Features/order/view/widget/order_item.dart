import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoppizel/Features/rate/view/widget/rate_products.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';
import '../../data/order_model.dart';

class OrderItem extends StatelessWidget {
  final OrderModel orderModel;
  const OrderItem({super.key, required this.orderModel });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: screenHeight(context) * 0.2,
        child: Row(
          children: [
            Image.network(
              orderModel.products.first.imageUrl,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth(context) * .35,
                        child: Text(
                          orderModel.products.first.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                    Text(
                      "  +${orderModel.products.length - 1} other ",
                      style: const TextStyle(
                          fontSize: 14, color: AppConstants.appColor),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "date : ${DateFormat('dd-MM-yyyy').parse(orderModel.dateOfOrder)}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "Time : ${DateFormat('hh:mm a').format(DateTime.parse(orderModel.dateOfOrder))}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "arriving in : ${DateFormat('hh:mm a').format(DateTime.parse(orderModel.dateOfOrder).add(const Duration(hours: 3)))}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "Order NO : ${orderModel.orderId}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const Spacer(),
                orderModel.orderStatus == "Accepted"?  TextButton.icon(
                  onPressed: () {},
                  label: const Text("follow"),
                  icon: const Icon(Icons.location_on_outlined),
                  style: TextButton.styleFrom(
                      foregroundColor: AppConstants.appColor,
                      shape: const RoundedRectangleBorder()),
                ) :
                orderModel.isRated==true ? const SizedBox():TextButton.icon(
                  onPressed: () {
                    showBottomSheet(context: context, builder: (_)=>RateProducts(
                      rateBy: FirebaseAuth.instance.currentUser!.uid, products: orderModel.products, orderId: orderModel.orderId, )) ;
                  },
                  label:  const Text("Rate"),
                  icon:  const Icon(Icons.star_rate ,),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.yellow.shade800 ,
                      shape: const RoundedRectangleBorder()),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
