
class PromoModel{
  final String code ;
  final String? discount  ;
  final String validation ;
  final String store ;
  final int minOrder ;

  PromoModel({required this.code, this.discount, required this.validation  , required this.store , required this.minOrder});

  factory PromoModel.fromJson(Map<String  , dynamic>json)=>PromoModel(


      code: json['code'] ,
  discount: json['discount'] ,
    validation: json['validation'],
    store: json['store'] ,
    minOrder: json['minOrder']

  ) ;

  Map<String , dynamic> toJson()=>{
    "code":code ,
    "discount"  :discount ,
    "validation":validation ,
    "store":store ,
    "minOrder":minOrder


  };









}