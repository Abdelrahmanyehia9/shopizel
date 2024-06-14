import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/home/data/repository/store_repo.dart';
import '../../data/model/product_model.dart';
import '../../data/model/store_model.dart';
import '../widgets/store/store_collection.dart';

class StoreScreen extends StatefulWidget {
  final StoreModel storeModel ;
  final List<ProductModel> storeCollection ;
  const StoreScreen({super.key, required this.storeModel , required this.storeCollection});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late StoreRepo repo ; 
  @override
  void initState() {
     repo = StoreRepo(storeCollection: widget.storeCollection) ;    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(widget.storeModel.color)),
        iconTheme: const IconThemeData(color: Colors.white),
        title:  Text(
          widget.storeModel.name,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ContainedTabBarView(
        tabBarProperties: TabBarProperties(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Color(int.parse(widget.storeModel.color)),
          labelColor: Color(int.parse(widget.storeModel.color))
        ),
        tabs: [
          tabs(name: "All"),
          tabs(name: "Men"),
          tabs(name: "Women"),
          tabs(name: "Kids"),
        ],
        views:  [
          GenderShop(collections: widget.storeCollection, repo: repo,storeInfo: widget.storeModel,),
          GenderShop(collections: repo.getGenderClothes("Men" ,) , repo:  repo, storeInfo: widget.storeModel , gender: "Men",),
          GenderShop(collections: repo.getGenderClothes("Women") , repo: repo, storeInfo:  widget.storeModel , gender: "Women",),
          GenderShop(collections: widget.storeCollection, repo: repo,storeInfo:  widget.storeModel , gender: "Kids",),
        ],
      ),
    );
  }

  Widget tabs({required String name}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      );
}
