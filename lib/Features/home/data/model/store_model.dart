class StoreModel{


  final String name;
  final String image ;
  final List<dynamic> features ;
  final String  rate ;
  final String count ;
  final String deliveryFees  ;
  final String deliveryTime ;

  StoreModel({required this.name, required this.image, required this.features, required this.rate, required this.count, required this.deliveryFees, required this.deliveryTime});



factory StoreModel.fromJson(Map<String , dynamic>json)=>StoreModel(
    name: json['name'], image: json['image'], features: json['features'], rate: json['rate'], count: json['count'], deliveryFees: json['deliveryFees'],
    deliveryTime: json['deliveryTime']) ;

Map<String , dynamic> toJson()=> {

  "name":name ,
  "image":image ,
  "features":features ,
  "rate":rate,
  "count":count,
  "deliveryFees":deliveryFees ,
  "deliveryTime":deliveryTime




} ;











}