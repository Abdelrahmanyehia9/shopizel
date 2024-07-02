class LocationModel {
  final String tittle;

  final String building;
  final String flatNumber;
  final int floor;
  final String specialMark;
  final String lat;
  final String long;
  final String name ;
  final String type ;
    bool isSelected ;
    final String? dateOfAdded ;

  LocationModel({required this.tittle,
    required this.building,
    required this.flatNumber,
    required this.floor,
    required this.specialMark,
    required this.lat,
    required this.long
  ,required this.name ,
  required this.type ,
  required this.isSelected ,
   this.dateOfAdded});


  factory LocationModel.fromJson(Map<String, dynamic> json){
    return LocationModel(
        tittle: json["tittle"],
        building: json["building"],
        flatNumber: json["flatNumber"],
        floor: json["floor"],
        specialMark: json["specialMark"],
        lat: json["lat"],
        long: json["long"] ,
    name :json['name'] ,
    type:json["type"] ,
    isSelected: json["isSelected"]) ;
  }
  Map<String , dynamic>toJson()=>{
    "building":building ,
    "flatNumber" :flatNumber,
    "floor":floor ,
    "specialMark" : specialMark ,
    "lat": lat ,
    "long":long ,
    "name":name ,
    "type":type ,
    "isSelected":isSelected ,
    "tittle":tittle ,
    "dateOfAdded" : dateOfAdded






  };
}
