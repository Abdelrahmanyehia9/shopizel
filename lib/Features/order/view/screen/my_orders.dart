import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/order/controller/order_cubit.dart';
import 'package:shoppizel/Features/order/controller/order_state.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/widgets/loading_failure.dart';
import '../widget/my_order_view.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    BlocProvider.of<OrderCubit>(context).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
        if (state is GetOrderLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetOrderSuccess) {
          return ContainedTabBarView(
            tabBarProperties: const TabBarProperties(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppConstants.appColor,
                labelColor: AppConstants.appColor),
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Text("All"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Text("on Going"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Text("Completed"),
              )
            ],
            views: [
              ///all
              MyOrdersView(
                orders: state.allOrders,
              ),
              MyOrdersView(
                orders: state.onGoingOrders,
              ),
              MyOrdersView(
                orders: state.completedOrders,
              ),
            ],
          );
        } else {
          return const LoadingFailure();
        }
      }),
    );
  }
}
