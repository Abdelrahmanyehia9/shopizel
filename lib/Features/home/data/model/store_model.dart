
class StoreModel {
  final String name;
  final String image;
  final List<ShopCategory> shopCategory;
  final String rate;
  final String count;
  final String deliveryFees;
  final String deliveryTime;
  final String lat;
  final String long;
  final String color;
  final String? offer;
  final String? specialOffer ;

  StoreModel(
      {required this.name,
      required this.image,
      required this.shopCategory,
        required this.rate,
      required this.count,
      required this.deliveryFees,
      required this.deliveryTime,
      required this.color,
      required this.offer,
      required this.long,
      required this.lat ,
      this.specialOffer});

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
      name: json['name'],
      image: json['image'],
      shopCategory: (json['features'] as List<dynamic>?)!.map((e) {
        return ShopCategory.fromJson(e as Map<String, dynamic>);
      }).toList(),
      rate: json['rate'],
      count: json['count'],
      deliveryFees: json['deliveryFees'],
      deliveryTime: json['deliveryTime'],
      lat: json['lat'],
      long: json['long'],
      offer: json['backgroundImg'],
      color: json['color'] ,
      specialOffer: json['specialOffer']);


  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'features': shopCategory.map((e) => e.toJson()).toList(),
    'rate': rate,
    'count': count,
    'deliveryFees': deliveryFees,
    'deliveryTime': deliveryTime,
    'lat': lat,
    'long': long,
    'backgroundImg': offer,
    'color': color,
    "specialOffer":specialOffer
  };}

class ShopCategory {
  final String name;

  final String image;

  ShopCategory({required this.image, required this.name});

  factory ShopCategory.fromJson(Map<String, dynamic> json) =>
      ShopCategory(image: json["image"], name: json['name']);


  Map<String , dynamic> toJson()=>{
    "image":image ,
    "name":name

  } ;
}

