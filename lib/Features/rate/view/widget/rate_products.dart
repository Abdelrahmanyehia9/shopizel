import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Auth/view/widgets/auth_textfeild.dart';
import 'package:shoppizel/Features/rate/controller/rate_cubit.dart';
import 'package:shoppizel/Features/rate/controller/rate_state.dart';
import 'package:shoppizel/Features/rate/data/rate_model.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:shoppizel/core/widgets/primary_button.dart';
import '../../../cart/data/model/cart_model.dart';

class RateProducts extends StatefulWidget {
  final List<CartModel> products;
  final String rateBy ;
  const RateProducts({super.key , required this.rateBy , required this.products});

  @override
  State<RateProducts> createState() => _RateProductsState();
}

class _RateProductsState extends State<RateProducts> {
  List<TextEditingController> controllers = [] ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: AppConstants.circularGradient
          ),
          height: screenHeight(context)*.62,
          width: screenWidth(context) ,
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(itemCount: widget.products.length,
                    itemBuilder: (context , index) {
                  for(int i = 0 ; i< widget.products.length ; i++){
                    controllers.add(TextEditingController()) ;
                  }
                      return rateItem(context , widget.products[index] , controllers[index]  );
                    }),
              )) ,
               BlocConsumer<RateCubit , RateState>(
                 listener: (context  , state){
                   if(state is AddRateSuccess){
                     Navigator.pop(context) ;
                   }
                 },
                 builder: (context , state){
                   if (state is AddRateLoading){
                     return const Center(child: CircularProgressIndicator(color: Colors.white,));
                   }else{
                     return Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                       child: PrimaryButton(label: "rate" , color: Colors.white,onTap: (){
                         List<RateModel> rates = [] ;
                         for(int i = 0  ; i< widget.products.length ; i ++ ){
                           RateModel model = RateModel(rateBy: FirebaseAuth.instance.currentUser!.uid , product: widget.products[i], desc: controllers[i].text, rateCount: 3) ;
                           rates.add(model);
                         }
                         BlocProvider.of<RateCubit>(context).addNewRate(rates) ;
                       },),
                     ) ;
                   }
                 },

               )
            ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.pop(context) ;
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.close , color: Colors.white,),
          ),
        )
      ],
    );
  }

  Widget rateItem(context , CartModel model  , TextEditingController controller )=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [

        ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: screenHeight(context)*0.25,
          width: screenWidth(context)*.5,
          child: CachedNetworkImage(fit: BoxFit.cover,
            imageUrl: model.imageUrl , placeholder: (context , url)=>const Center(child: CircularProgressIndicator()),),
        ),
      ) ,
        const SizedBox(height: 10,) ,

        Text(model.name , style: const TextStyle(color: Colors.white , fontWeight: FontWeight.bold),) ,
        const ProductRatingStars(),
        DescriptionRate(controller: controller,)
    ],)
  ) ;
}


class ProductRatingStars extends StatefulWidget {
  const ProductRatingStars({super.key});
  @override
 State<ProductRatingStars> createState() => _ProductRatingStarsState();
}

class _ProductRatingStarsState extends State<ProductRatingStars> {
  double value = 3;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: RatingStars(
        value: value,
        onValueChanged: (v) {
          //
          setState(() {
            value = v;
          });
        },
        starBuilder: (index, color) => Icon(
          Icons.star ,
          color: color,
        ),
        starCount: 5,
        starSize: 20,
        valueLabelColor: const Color(0xff9b9b9b),
        valueLabelTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
        valueLabelRadius: 10,
        maxValue: 5,
        starSpacing: 2,
        maxValueVisibility: true,
        valueLabelVisibility: true,
        animationDuration: const Duration(milliseconds: 1000),
        valueLabelPadding:
        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        valueLabelMargin: const EdgeInsets.only(right: 8),
        starOffColor: const Color(0xffe7e8ea),
        starColor: Colors.yellow,
      ),
    ) ;

  }
}



class DescriptionRate extends StatelessWidget {
  final TextEditingController controller ;
 const DescriptionRate({super.key  ,required this.controller});
  @override
  Widget build(BuildContext context) {
    return  Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Description" , style: TextStyle(color: Colors.white),) ,
        SizedBox(
          child: TextFormField(
            controller: controller,
            maxLines:3 ,
        cursorColor: AppConstants.appColor,
            decoration:  InputDecoration(

              hintText: "ex. Very Good Material" ,
              filled:  true ,
              fillColor:  Colors.white.withOpacity(0.75) ,
              border: const OutlineInputBorder(borderSide: BorderSide.none)
            ),


          ),
        ),
      ],
    );
  }
}
