import '../data/model/product_model.dart';

abstract class GenderState{}
class GenderStateInitial extends GenderState{}
class GenderStateLoading extends GenderState{}
class GenderStateFailure extends GenderState{}
class GenderStateSuccess extends GenderState{
  GenderStateSuccess({required this.collection , required this.cat}) ;
  List<ProductModel>  collection ;
  List<String>cat ;
}
