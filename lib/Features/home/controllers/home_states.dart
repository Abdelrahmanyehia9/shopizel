import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/data/model/store_model.dart';

import '../data/model/category_model.dart';

abstract class HomeStates {

}
class HomeStateInitial extends HomeStates{}
class HomeStateLoading extends HomeStates{}
class HomeStateSuccess extends HomeStates{

  final List<CategoryModel> categories ;
  final List<StoreModel> stores ;
  HomeStateSuccess({required this.categories , required this.stores  }) ;
}
class HomeStateFailure extends HomeStates{


  final String errorMessage ;
  HomeStateFailure(this.errorMessage) ;
}