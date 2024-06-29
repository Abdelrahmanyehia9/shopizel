class CartModel {
  final int productId;
  final String imageUrl;
final String name;
  final String size;
  final String color;
  final int quantity;
  final String madeBy;
  final String price;
  final String sale;
  final String? dateTime ;

  CartModel(
      {required this.productId,
      required this.size,
      required this.color,
      required this.quantity,
      required this.madeBy,
      required this.price,
      required this.sale,
      required this.imageUrl ,
      required this.name ,
       this.dateTime});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      productId: json["productId"],
      size: json["size"],
      color: json["color"],
      quantity: json["quantity"],
      madeBy: json["madeBy"],
      price: json["price"],
      sale: json["sale"],
      imageUrl: json["imageUrl"] ,
  name: json['name'] ,
  dateTime:json['date']);

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "size": size,
        "color": color,
        "quantity": quantity,
        "madeBy": madeBy,
        "price": price,
        "sale": sale,
        "imageUrl": imageUrl ,
    "name":name ,
    "date":DateTime.now().toString()
      };
}
