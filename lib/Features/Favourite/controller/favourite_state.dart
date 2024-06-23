abstract class FavouriteStates {}
class AddFavouriteStateInitial extends FavouriteStates {}
class AddFavouriteStateLoading extends FavouriteStates {}
class AddFavouriteStateSuccess extends FavouriteStates {}
class AddFavouriteStateFailure extends FavouriteStates {

  final String errorMsg ;
  AddFavouriteStateFailure({required this.errorMsg});
}