import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shoppizel/Features/Auth/controller/auth_cubit.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/controller/search_by_photo_cubit.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/data/repository/search_by_photo_repo.dart';
import 'package:shoppizel/Features/Machine/robot/controller/clothes_measure_cubit.dart';
import 'package:shoppizel/Features/Machine/robot/controller/fitting_room_cubit.dart';
import 'package:shoppizel/Features/Machine/robot/data/repo/clothes_measure_repo.dart';
import 'package:shoppizel/Features/Machine/robot/data/repo/fitting_room_repo.dart';
import 'package:shoppizel/Features/order/controller/order_cubit.dart';
import 'package:shoppizel/Features/order/data/order_repo.dart';
import 'package:shoppizel/Features/Favourite/controller/favourite_cubit.dart';
import 'package:shoppizel/Features/Favourite/data/repository/favourite_repository.dart';
import 'package:shoppizel/Features/cart/data/repository/cart_repo.dart';
import 'package:shoppizel/Features/home/controllers/gender_Cubit.dart';
import 'package:shoppizel/Features/home/controllers/home_cubit.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/location/controller/location_cubit.dart';
import 'package:shoppizel/Features/location/data/location_repo.dart';
import 'package:shoppizel/Features/profile/controller/profile_cubit.dart';
import 'package:shoppizel/Features/profile/data/profile_repo.dart';
import 'package:shoppizel/Features/promo/controller/promo_cubit.dart';
import 'package:shoppizel/Features/promo/data/promo_code_repo.dart';
import 'package:shoppizel/Features/rate/controller/rate_cubit.dart';
import 'package:shoppizel/core/database/api_helper.dart';
import 'package:shoppizel/core/service/single_ton.dart';
import 'package:shoppizel/searching.dart';
import 'Features/Machine/robot/view/robot_view.dart';
import 'Features/cart/controller/cart_cubit.dart';
import 'Features/home/controllers/store_cubit.dart';
import 'Features/home/data/repository/store_repo.dart';
import 'Features/home/view/screens/home_screen.dart';
import 'Features/rate/data/rate_repo.dart';
import 'core/utils/app_constants.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setup() ;
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
        BlocProvider(create: (context) => ProfileCubit(ProfileRepo())..fetchProfile() ),
        BlocProvider(create: (context)=> OrderCubit(OrderRepo())) ,
        BlocProvider(create: (context)=>PromoCubit(PromoCodeRepo())..getAllPromo()) ,
        BlocProvider(create: (context)=>RateCubit(repo:RateRepo())) ,
        BlocProvider(create: (context)=>SearchByPhotoCubit(SearchByPhotoRepo(getIt.get<ApiHelper>()))) ,
        BlocProvider(create: (context)=> FittingRoomCubit(FittingRoomRepo(helper: getIt.get<ApiHelper>()))) ,
        BlocProvider(create: (context)=> ClothesMeasureCubit(ClothesMeasureRepo(helper: getIt.get<ApiHelper>())))
      ],
      child: MaterialApp(
        home:   const HomeScreen() , 
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
