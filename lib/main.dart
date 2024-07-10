import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latlong2/latlong.dart';
import 'package:shoppizel/Features/Auth/controller/auth_cubit.dart';
import 'package:shoppizel/Features/Auth/view/screens/login_screen.dart';
import 'package:shoppizel/Features/home/view/screens/store_screen.dart';
import 'package:shoppizel/Features/order/controller/order_cubit.dart';
import 'package:shoppizel/Features/order/data/order_repo.dart';
import 'package:shoppizel/Features/order/view/screen/my_orders.dart';
import 'package:shoppizel/Features/order/view/screen/order_screen.dart';
import 'package:shoppizel/Features/payment/view/screen/choose_payment_method.dart';
import 'package:shoppizel/Features/profile/view/screen/edit_profile.dart';
import 'package:shoppizel/Features/profile/view/screen/profile_screen.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/cart/data/repository/cart_repo.dart';
import 'package:shoppizel/Features/cart/view/screen/cart_screen.dart';
import 'package:shoppizel/Features/home/controllers/gender_Cubit.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/location/controller/location_cubit.dart';
import 'package:shoppizel/Features/location/data/location_repo.dart';
import 'package:shoppizel/Features/location/view/screen/saved_addresses.dart';
import 'package:shoppizel/Features/profile/controller/profile_cubit.dart';
import 'package:shoppizel/Features/profile/data/profile_repo.dart';
import 'package:shoppizel/Features/promo/controller/promo_cubit.dart';
import 'package:shoppizel/Features/promo/data/promo_code_repo.dart';
import 'package:shoppizel/Features/rate/controller/rate_cubit.dart';

import 'Features/cart/controller/cart_cubit.dart';
import 'Features/home/controllers/store_cubit.dart';
import 'Features/home/data/repository/store_repo.dart';
import 'Features/home/view/screens/home_screen.dart';
import 'Features/location/view/screen/get_location_permission.dart';
import 'Features/location/view/screen/adress_screen.dart';
import 'Features/payment/view/screen/order_confirmed.dart';
import 'Features/rate/data/rate_repo.dart';
import 'core/utils/app_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Tship());
}

class Tship extends StatelessWidget {
  const Tship({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit(HomeRepo())),
        BlocProvider(create: (context) => StoreCubit(StoreRepo())),
        BlocProvider(create: (context) => GenderCubit(HomeRepo())),
        BlocProvider(create: (context) => FavouriteCubit(FavouriteRepo())),
        BlocProvider(create: (context) => CartCubit(CartRepo())),
        BlocProvider(create: (context) => LocationCubit(LocationRepo())),
        BlocProvider(create: (context) => ProfileCubit(ProfileRepo())),
        BlocProvider(create: (context)=> OrderCubit(OrderRepo())) ,
        BlocProvider(create: (context)=>PromoCubit(PromoCodeRepo())..getAllPromo()) ,
        BlocProvider(create: (context)=>RateCubit(repo:RateRepo())) ,




      ],
      child: MaterialApp(
        home: const HomeScreen() ,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
elevatedButtonTheme: const ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.white) ,
    overlayColor: WidgetStatePropertyAll(Colors.teal),
    backgroundColor: WidgetStatePropertyAll(AppConstants.appColor) ,
    shape: WidgetStatePropertyAll(RoundedRectangleBorder())
  )
) , 
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          fontFamily: AppConstants.fontFamily,
          appBarTheme: const AppBarTheme(color: AppConstants.appColor , foregroundColor: Colors.white , centerTitle: true) ,
          scaffoldBackgroundColor: const Color(0xffECF0F4),
        ),
      ),
    );
  }
}
