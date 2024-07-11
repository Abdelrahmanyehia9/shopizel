import '../../Auth/data/model/user_model.dart';
import '../../cart/data/model/cart_model.dart';

class RateModel {
  final UserModel rateBy;
  final CartModel product;
  final String desc;
  final int rateCount;
  final String dateRates ;

  RateModel(
      {required this.rateBy   , required this.product, required this.desc, required this.rateCount , required this.dateRates});

  factory RateModel.fromJson(Map<String, dynamic> json) =>
      RateModel(
        rateBy: UserModel.fromJson(json["rateBy"]),
        product: CartModel.fromJson(json['product']),
        desc: json["desc"],
        rateCount: json["rateCount"],
        dateRates: json["dateOfRate"]


      ) ;
  Map<String , dynamic>toJson()=>{
    "product": product.toJson() ,
    "rateBy": rateBy.toJson(),
    "desc":desc ,
    "rateCount":rateCount ,
    "dateOfRate":dateRates


  } ;


}