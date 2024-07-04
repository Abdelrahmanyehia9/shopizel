import '../../Auth/data/model/user_model.dart';
import '../../cart/data/model/cart_model.dart';
import '../../location/data/model.dart';

class OrderModel {
  final String orderId;
  final String dateOfOrder;
  final String paymentMethod;
  final List<CartModel> products;
  final UserModel userModel;
  final String orderStatus;
  final LocationModel location ;

  OrderModel({
    required this.orderId,
    required this.dateOfOrder,
    required this.paymentMethod,
    required this.products,
    required this.userModel,
    required this.orderStatus,
    required this.location
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var productsList = json['products'] as List<dynamic>;
    List<CartModel> parsedProducts =
    productsList.map((item) => CartModel.fromJson(item)).toList();

    return OrderModel(
      orderId: json["orderId"],
      dateOfOrder: json["dateOfOrder"],
      paymentMethod: json["paymentMethod"],
      products: parsedProducts,
      userModel: UserModel.fromJson(json["user"]),
      orderStatus: json["orderStatus"],
      location:  LocationModel.fromJson(json["location"])
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJson =
    products.map((product) => product.toJson()).toList();

    return {
      "orderId": orderId,
      "dateOfOrder": dateOfOrder,
      "paymentMethod": paymentMethod,
      "products": productsJson,
      "user": userModel.toJson(),
      "orderStatus": orderStatus,
      "location":location.toJson()
    };
  }
}
