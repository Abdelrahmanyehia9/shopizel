import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppizel/Features/cart/controller/cart_cubit.dart';
import 'package:shoppizel/Features/cart/controller/cart_state.dart';
import 'package:shoppizel/Features/cart/data/model/cart_model.dart';
import 'package:shoppizel/Features/cart/view/screen/cart_screen.dart';
import 'package:shoppizel/Features/location/data/model.dart';
import 'package:shoppizel/Features/order/data/model.dart';
import 'package:shoppizel/Features/order/data/repo.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import '../../../Auth/data/model/user_model.dart';
import '../../../profile/controller/profile_cubit.dart';
import '../widgets/home/home_body.dart';
import '../widgets/home/home_drawer.dart';
import '../widgets/home/my_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel userModel = UserModel(
      uid: FirebaseAuth.instance.currentUser!.uid,
      email: "example@yahoo.com",
      username: "Guest",
      number: "0123456789"
  );

  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).fetchCartProducts();
    BlocProvider.of<ProfileCubit>(context).fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(
        userModel: userModel,
      ),
      body: CustomScrollView(
        slivers: [
          homeAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                HomeBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar homeAppBar() =>
      SliverAppBar(
        foregroundColor: Colors.black,
        expandedHeight: screenHeight(context) * .32,
        scrolledUnderElevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(

            decoration: const BoxDecoration(
                gradient: AppConstants.circularGradient
            )
            , padding: EdgeInsets.only(top: kToolbarHeight + MediaQuery
              .of(context)
              .padding
              .top + 12,
              right: screenWidth(context) * .05,
              left: screenWidth(context) * .05),

            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sale 40% ", style: TextStyle(fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                    const SizedBox(height: 2,),
                    SizedBox(width: screenWidth(context) * 0.45,
                        child: Text(
                          "save 40% on first order use code 'FIRST40' ",
                          style: TextStyle(
                              color: Colors.grey.shade100, fontSize: 14),)),
                    const SizedBox(height: 8,),

                    InkWell(
                      onTap: () async {
                        List<CartModel> products = [
                          CartModel(
                            productId: 2,
                            size: "XL",
                            color: "black",
                            quantity: 2,
                            madeBy: "zara",
                            price: "22",
                            sale: "20",
                            imageUrl: "imageUrl",
                            name: "name",),
                          CartModel(productId: 2,
                              size: "size",
                              color: "color",
                              quantity: 2,
                              madeBy: "madeBy",
                              price: "price",
                              sale: "sale",
                              imageUrl: "imageUrl",
                              name: "name")
                        ];
                        LocationModel location = LocationModel(tittle: "tittle",
                            building: "fdf",
                            flatNumber: "flatNumber",
                            floor: 4,
                            specialMark: "specialMark",
                            lat: "lat",
                            long: "long",
                            name: "name",
                            type: "type",
                            isSelected: false) ;
                        OrderModel order = OrderModel(orderId: "3",
                            dateOfOrder: DateTime.now().toString(),
                            paymentMethod: "cash",
                            products: products,
                            userModel: userModel,
                            orderStatus: "accepted",
                            location: location);
                        await OrderRepo().placeAOrder(order);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: const Text("Use Now", style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      ),
                    )


                  ],),
                SizedBox(width: screenWidth(context) * .45,
                    height: screenHeight(context) * .3,
                    child: Image.asset("assets/images/pngwing.com (36).png",
                      fit: BoxFit.fitHeight,))
              ],
            ),
          ),

        ),
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
                  color: AppConstants.appColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen())
                );
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
                        backgroundColor: AppConstants.appColor,
                        radius: 12,
                        child: Text(
                          state.cartCount.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppConstants.fontFamily
                          ),
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
