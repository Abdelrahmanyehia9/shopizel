import '../data/model/product_model.dart';

abstract class StoreState {

}
class StoreStateInitial extends StoreState {}
class StoreStateSuccess extends StoreState {
  final List<ProductModel> collection ;
  StoreStateSuccess(this.collection) ;
}
class StoreStateFailure extends StoreState {}
class StoreStateLoading extends StoreState {}