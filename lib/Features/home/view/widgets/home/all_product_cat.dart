import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppizel/Features/home/controllers/gender_Cubit.dart';
import 'package:shoppizel/Features/home/controllers/gender_state.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/home/data/repository/store_repo.dart';
import 'package:shoppizel/Features/home/view/screens/product_spacific_cat.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';
import 'package:shoppizel/core/utils/app_constants.dart';
import 'package:shoppizel/core/widgets/loading_failure.dart';

import '../../../../../core/utils/screen_dimentions.dart';
import '../../../../../core/widgets/loading.dart';
import 'search_textfield.dart';
import '../store/clothes_cat.dart';
import '../store/product_item.dart';

class AllProductCat extends StatefulWidget {
  const AllProductCat({super.key , required this.gender});
final String gender ;
  @override
  State<AllProductCat> createState() => _AllProductCatState();
}

class _AllProductCatState extends State<AllProductCat> {


  @override
  void initState() {
    BlocProvider.of<GenderCubit>(context).fetch(widget.gender);
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title:  Text("T-Ship ${widget.gender} Products" , style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
          scrolledUnderElevation: 0,
        ),

        body:  BlocBuilder<GenderCubit , GenderState>(
            builder: (context ,state){
              if (state is GenderStateSuccess){
List<String> cat = state.cat.toSet().toList(  ) ;
                if(state.collection.isNotEmpty){
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                  
                        child: SizedBox(
                          height: screenHeight(context) * 0.19,
                          child: ListView.builder(
                            itemCount: cat.length ,
                            itemBuilder: (context, index) => ClothesCat(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => ProductsSpecificCat(collection: StoreRepo().getTypeOfClothes(state.collection, cat[index]), color: AppConstants.appColor.value.toString()) ) );
                              },
                                color: AppConstants.appColor.value.toString(),
                                text: cat[index]),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox( width: screenWidth(context)*0.8,
                                child: const SearchTextField(productOnly: true,)),
                            const Icon(Icons.filter_alt) ,
                            const Icon(Icons.sort_sharp) ,
                          ],
                        ),
                      ) ,
                      StaggeredGridView.countBuilder(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        itemCount: state.collection.length,
                        itemBuilder: (BuildContext context, int index) => Center(
                            child: ProductItem(
                              model: state.collection[index],
                              color: AppConstants.appColor.value.toString(),
                            )),
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.count(1, index.isEven ? 2.2 : 1.4),
                        mainAxisSpacing: 8.0,
                      ),
                    ],
                  ),
                ) ;}
                else{
                  return Center(child:  Text ("No Product Here"),) ; 
                }
              }
              else if (state is GenderStateFailure){
                return const LoadingFailure() ;
              }else{
                return const AllProductCatLoading() ;
              }




            },
          ),
        );
  }
}
