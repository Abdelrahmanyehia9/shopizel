class LocationModel {
  final String tittle;

  final String building;
  final String flatNumber;
  final int floor;
  final String specialMark;
  final String lat;
  final String long;
  final String name ;

  LocationModel({required this.tittle,
    required this.building,
    required this.flatNumber,
    required this.floor,
    required this.specialMark,
    required this.lat,
    required this.long
  ,required this.name});


  factory LocationModel.fromJson(Map<String, dynamic> json){
    return LocationModel(
        tittle: json["tittle"],
        building: json["building"],
        flatNumber: json["flatNumber"],
        floor: json["floor"],
        specialMark: json["specialMark"],
        lat: json["lat"],
        long: json["long"] ,
    name :json['name']) ;
  }
  Map<String , dynamic>toJson()=>{
    "building":building ,
    "flatNumber" :flatNumber,
    "floor":floor ,
    "specialMark" : specialMark ,
    "lat": lat ,
    "long":long ,
    "name":name






  };
}
