
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/utils/app_router.dart';
import 'package:shoppizel/core/utils/screen_dimentions.dart';

import '../widgets/store/store_collection.dart';

class StoreScreen extends StatelessWidget {

  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade700,
         iconTheme: IconThemeData(color: Colors.white),
        title : Text("Lc Waikiki" , style: TextStyle(color: Colors.white),) , centerTitle: true,
      ),
body: ContainedTabBarView(
  tabBarProperties:  TabBarProperties(

indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: Colors.transparent ,
      labelColor: Colors.blueAccent.shade700 ,
  ),
  tabs: const [
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('All', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Men', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Women', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
    ) ,
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Kids', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
    ),

  ],
  views: const [
    StoreCollection () ,
    StoreCollection () ,
    StoreCollection () ,
    StoreCollection () ,


  ],
  onChange: (index) => print("--------------------"+ index.toString()),
),

    );
  }


}
