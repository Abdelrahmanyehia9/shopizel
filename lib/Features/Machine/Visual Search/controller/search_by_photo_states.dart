import '../../../home/data/model/product_model.dart';
import '../data/model/visual_search_model.dart';

abstract class SearchByPhotoStates {}
class SearchByPhotoStateInitial extends SearchByPhotoStates {}
class SearchByPhotoStateFailure extends SearchByPhotoStates {

  final String errorMessage ;
  SearchByPhotoStateFailure({required this.errorMessage});
}
class SearchByPhotoStateSuccess extends SearchByPhotoStates{
  final List<VisualSearchModel> predicted;
  final List<ProductModel> products  ;

  SearchByPhotoStateSuccess({required this.predicted, required this.products});
}
class SearchByPhotoLoading extends SearchByPhotoStates{}
