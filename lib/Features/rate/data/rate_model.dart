import '../../cart/data/model/cart_model.dart';

class RateModel {
  final String rateBy;
  final CartModel product;
  final String desc;
  final int rateCount;

  RateModel(
      {required this.rateBy, required this.product, required this.desc, required this.rateCount});

  factory RateModel.fromJson(Map<String, dynamic> json) =>
      RateModel(
        rateBy: json["rateBy"],
        product: CartModel.fromJson(json['product']),
        desc: json["desc"],
        rateCount: json["rateCount"],


      ) ;
  Map<String , dynamic>toJson()=>{
    "product": product.toJson() ,
    "rateBy":rateBy ,
    "desc":desc ,
    "rateCount":rateCount


  } ;


}