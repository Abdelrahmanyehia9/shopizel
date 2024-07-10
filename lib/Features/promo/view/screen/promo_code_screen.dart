import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/promo/controller/promo_cubit.dart';
import 'package:shoppizel/Features/promo/controller/promo_state.dart';
import 'package:shoppizel/Features/shimmer/promo_codes_loading.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../widget/promo_code_item.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({super.key});

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  @override
  void initState() {
    BlocProvider.of<PromoCubit>(context).getAllPromo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Promo Code"),
      ),
      body: BlocBuilder<PromoCubit, PromoState>(
        builder: (context, state) {
          if (state is GetAllPromoSuccess) {
            if(state.allPromo.isEmpty){
              return const NoPromoCodes() ;
            }else{
              return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(itemCount: state.allPromo.length,
                      itemBuilder: (context , index) =>
                          PromoCodeItem(promoModel: state.allPromo[index]) )
              );
            }
          }else{
            return const  PromoCodesLoading();
          }
        },
      ),
    );
  }
}

class NoPromoCodes extends StatelessWidget {
  const NoPromoCodes({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
    child: SizedBox(
      width: screenWidth(context),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight(context)*0.5,
              width: double.infinity,
              child: Image.asset("assets/images/pngegg (1).png" , fit: BoxFit.fitHeight,)),
          const SizedBox(height: 15,) ,
          const Text("unfortunately No available Code this Time Try again later" , textAlign: TextAlign.center , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold ,color: AppConstants.appColor),)
        ],
      ) ,

    ),
    ) ;

  }
}
