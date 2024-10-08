
class StoreModel {
  final String name;
  final String image;
  final List<ShopCategory> shopCategory;
  final List<ClothesCategory> clothesCategory;
  final String rate;
  final String count;
  final String deliveryFees;
  final String deliveryTime;
  final String lat;
  final String long;
  final String color;
  final String backgroundImg;

  StoreModel(
      {required this.name,
      required this.image,
      required this.shopCategory,
        required this.clothesCategory,
        required this.rate,
      required this.count,
      required this.deliveryFees,
      required this.deliveryTime,
      required this.color,
      required this.backgroundImg,
      required this.long,
      required this.lat});

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
      name: json['name'],
      image: json['image'],
      clothesCategory: (json['categories'] as List<dynamic>?)!.map((e) {
        return ClothesCategory.fromJson(e as Map<String, dynamic>);
      }).toList(),
      shopCategory: (json['features'] as List<dynamic>?)!.map((e) {
        return ShopCategory.fromJson(e as Map<String, dynamic>);
      }).toList(),
      rate: json['rate'],
      count: json['count'],
      deliveryFees: json['deliveryFees'],
      deliveryTime: json['deliveryTime'],

      lat: json['lat'],
      long: json['long'],
      backgroundImg: json['backgroundImg'],
      color: json['color']);


  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'categories': clothesCategory.map((e) => e.toJson()).toList(),
    'features': shopCategory.map((e) => e.toJson()).toList(),
    'rate': rate,
    'count': count,
    'deliveryFees': deliveryFees,
    'deliveryTime': deliveryTime,
    'lat': lat,
    'long': long,
    'backgroundImg': backgroundImg,
    'color': color,
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
class ClothesCategory {
  final String name;
  final String image;
  final String gender ;

  ClothesCategory({required this.image, required this.name , required this.gender});

  factory ClothesCategory.fromJson(Map<String, dynamic> json) =>
      ClothesCategory(image: json["image"], name: json['name'] , gender: json['gender']);

  Map<String , dynamic> toJson()=>{
    "image":image ,
    "name":name ,
    "gender":gender


  } ;

}

