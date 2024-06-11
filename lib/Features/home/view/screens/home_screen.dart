import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: homeAppBar(context) ,
      drawer: Drawer(
        child: ListView(

        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: HomeBody(),
      )
    );
  }

  PreferredSizeWidget homeAppBar(BuildContext context){
    return AppBar(

      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('DELIVER TO' , style:  TextStyle(fontFamily: AppConstants.fontFamily , color: AppConstants.btnColor , fontSize: 12 , fontWeight: FontWeight.bold),),
          Text('haram , giza' , style:  TextStyle(fontFamily: AppConstants.fontFamily  , fontSize: 14 ),),

        ],
      ),
      leading:Padding(
        padding: EdgeInsets.only(left: 16 , right: 8),
        child: InkWell(onTap: (){

            _scaffoldKey.currentState?.openDrawer();

        },
            child: SvgPicture.asset("assets/images/Menu.svg" , )),
      ) ,
      actions: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 28.0),
             child: Stack(

             alignment: AlignmentDirectional.topEnd,
               children: [


                       SvgPicture.asset("assets/images/Ellipse 1294.svg" , fit: BoxFit.cover,),
                 const CircleAvatar(
                   backgroundColor: AppConstants.btnColor,
                   radius: 12,
                   child: Text("2" , style: TextStyle(color: Colors.white , fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: AppConstants.fontFamily),),
                 ) ,


               ],
             ),
           )
      ],
      leadingWidth: screenWidth(context)*0.2,

    ) ;

  }
}