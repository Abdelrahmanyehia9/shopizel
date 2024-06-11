import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/view/widgets/category_list.dart';
import 'package:shoppizel/Features/home/view/widgets/search_textfield.dart';
import 'package:shoppizel/Features/home/view/widgets/see_all.dart';
import 'package:shoppizel/Features/home/view/widgets/stores_list.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height:
        screenHeight(context)*0.035,) ,
        greetingText() ,
        const SizedBox(height: 12,) ,
        const SearchTextField() ,
        const SizedBox(height: 12,) ,
        const SeeAll(tittle: "All Category",) ,
        const SizedBox(height: 6,) ,
        const CategoryList(),
        const SeeAll(tittle: "Open Stores",) ,
        SizedBox(height: 16,) ,
        StoresList()








      ],
    );

  }
  Widget greetingText(){
    return  Text.rich(
      TextSpan(
          children: [
            TextSpan(text: 'Abdelrahman yehia younes'.split(" ").first, style: const TextStyle( fontSize: 15 , fontFamily: AppConstants.fontFamily)),
            const TextSpan(text: ', ', style: TextStyle( fontSize: 15 , fontFamily: AppConstants.fontFamily)),
            const TextSpan(text: 'Good Afternoon!', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16 , fontFamily: AppConstants.fontFamily)),
          ],
          text: "Hey " , style: const TextStyle(fontFamily: AppConstants.fontFamily , fontSize: 15)) ,
    ) ;

  }
}
