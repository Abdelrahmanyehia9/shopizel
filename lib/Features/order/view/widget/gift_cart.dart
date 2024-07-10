import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/order/controller/order_cubit.dart';
import 'package:shoppizel/Features/order/data/order_fees.dart';
import 'package:shoppizel/Features/promo/data/promo_model.dart';
import 'package:shoppizel/Features/promo/controller/promo_cubit.dart';
import 'package:shoppizel/Features/promo/data/promo_code_repo.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/screen_dimentions.dart';

class GiftCartTextField extends StatefulWidget {
  final String total ;
  final void Function(PromoModel?) promoGift;
  const GiftCartTextField({super.key , required this.total , required this.promoGift});

  @override
  State<GiftCartTextField> createState() => _GiftCartTextFieldState();
}

class _GiftCartTextFieldState extends State<GiftCartTextField> {
  String? promoApplied ; 
  String? promoError ; 
  final TextEditingController _controller = TextEditingController() ;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>() ;


  @override
  void initState() {
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         promoApplied == null ?  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth(context) * .7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 12),
                  child:  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "apply here",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )                 ),
              ),
              InkWell(
          onTap: () => checkValidate() ,
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth(context) * 0.25,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppConstants.gradient,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ) : Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(promoApplied! , style: TextStyle(fontSize: 16 , color: Colors.green),) , 
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 18.0),
               child: InkWell(onTap: (){
                 setState(() {
                   promoApplied = null ;
                 });
               },
                   child: Icon(Icons.close , color: Colors.green,size: 18,)),
             ) ,

           ],
         ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(promoError??"" , style: TextStyle(color: Colors.red , fontSize: 10),),
          )
        ],
      ),
    );

  }



  Future<void> checkValidate() async{

    String promo = _controller.text.toLowerCase().trim() ;
    PromoModel? model =await     BlocProvider.of<PromoCubit>(context).repo .applyPromo(promo);
    if(model != null ){
      if(DateTime.now().isAfter(DateTime.parse(model.validation))){
        setState(() {
          promoError = "code ${model.code.toUpperCase()} has been expired " ;
        });
      } else{
          setState(() {
            promoError = null ;
            promoApplied = "You have applied ${model.code.toUpperCase()}" ;

widget.promoGift(model);
          });


      }

    }else{
      setState(() {
        promoError =  "${promo} is not exist , try different one  " ;
      });
    }
  }
  @override
  void dispose() {
_controller.dispose() ;
super.dispose();
  }
}
