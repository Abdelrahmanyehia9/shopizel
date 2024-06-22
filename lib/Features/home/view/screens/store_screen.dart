import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/store_cubit.dart';
import 'package:shoppizel/Features/home/controllers/store_state.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/home/data/repository/store_repo.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';
import 'package:shoppizel/core/widgets/loading_failure.dart';
import '../../data/model/product_model.dart';
import '../../data/model/store_model.dart';
import '../widgets/store/store_collection.dart';

class StoreScreen extends StatefulWidget {
  final StoreModel storeModel ;
  const StoreScreen({super.key, required this.storeModel });

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
BlocProvider.of<StoreCubit>(context).getCollection(storeName: widget.storeModel.name) ;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit , StoreState>(
      builder:  (context , state){
        if (state is StoreStateSuccess){

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
                tab(name: "All"),
                tab(name: "Men"),
                tab(name: "Women"),
                tab(name: "Kids"),
              ],
              views:  [
                ///all
                StoreCollection(collections: state.collection , storeInfo: widget.storeModel),
                 ///men
                StoreCollection(collections:context.read<StoreCubit>().men , storeInfo: widget.storeModel),
                 ///women
                StoreCollection(collections: context.read<StoreCubit>().women, storeInfo: widget.storeModel),
                 ///kids
                StoreCollection(collections:context.read<StoreCubit>().kids , storeInfo: widget.storeModel),
              ],
            ),
          ) ;

        }
        else if (state is StoreStateFailure){
          return const LoadingFailure();
        }
        else{

          return const Center(child: CircularProgressIndicator(),);


        }



      },
    );
  }

  Widget tab({required String name}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      );
}
