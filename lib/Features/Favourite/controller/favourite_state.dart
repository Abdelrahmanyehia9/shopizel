import '../../home/data/model/product_model.dart';

abstract class FavouriteStates {}
class GetFavouriteStateInitial extends FavouriteStates {}
class GetFavouriteStateLoading extends FavouriteStates {}
class GetFavouriteStateSuccess extends FavouriteStates {

 final  List<ProductModel> favourites ;

  GetFavouriteStateSuccess({required this.favourites});
}
class GetFavouriteStateFailure extends FavouriteStates {

  final String errorMsg ;
  GetFavouriteStateFailure({required this.errorMsg});
}