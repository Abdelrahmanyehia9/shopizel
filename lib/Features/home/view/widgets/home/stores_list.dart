import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/home/view/widgets/home/store_item.dart';
import '../../../data/model/store_model.dart';

class StoresList extends StatelessWidget {
  const StoresList({super.key, required this.stores});

  final List<StoreModel> stores;

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        clipBehavior: Clip.hardEdge,
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return StoreItem(
            features: HomeRepo().getStoreShopCategories(stores[index]),
            storeModel: stores[index],
          );
        });
  }



  /// shipping fees , rate , delivery time

}
