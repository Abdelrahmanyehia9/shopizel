class CategoryModel {
  final String tittle;
  final String startPrice;
  final String imageUrl;
  CategoryModel(
      {required this.tittle, required this.startPrice, required this.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      tittle: json['tittle'],
      startPrice: json['start price'],
      imageUrl: json['image']);
  Map<String , dynamic> toJson()=>{

    "tittle" :tittle ,
    "start price":startPrice ,
    "image" : imageUrl

  };

}
