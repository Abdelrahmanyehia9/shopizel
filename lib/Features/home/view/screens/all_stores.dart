import 'package:flutter/material.dart';
import 'package:shoppizel/Features/home/view/widgets/home/stores_list.dart';

import '../../../../core/utils/app_constants.dart';
import '../../data/model/store_model.dart';

class AllStores extends StatelessWidget {
  final List<StoreModel> stores ;
  const AllStores({super.key , required this.stores});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context) ;
            },
            child: const Icon(Icons.close )),
        title: const Text(
          "Stores" ,
          style: TextStyle(fontWeight: FontWeight.bold ),
        ),

      ),
      body: StoresList(stores: stores,)

    );



  }
}
