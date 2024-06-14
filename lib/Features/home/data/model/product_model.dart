class ProductModel {
  final int id;
  final String name;
  final String desc;
  final String imageCover;
  final List<dynamic>? images;
  final List<dynamic> sizes;
  final List<dynamic> colors;
  final String madeBy;
  final String? rate;
  final String count;
  final String? price;
  final String? category;
  final String? sale;
  final String type;
  final String? dateTime ;

  ProductModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.imageCover,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.madeBy,
    required this.rate,
    required this.count,
    required this.price,
    required this.category,
    required this.sale,
    required this.type,
    this.dateTime
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id']??"",
      name: json['name']??"",
      imageCover: json['imageCover']??"",
      images: json['images']??"",
      sizes: json['sizes']??"",
      colors: json['colors']??"",
      madeBy: json['madeBy']??"",
      rate: json['rate']??"",
      count: json['count']??"",
      price: json['price']??"",
      category: json['category']??"",
      sale: json['sale']??"",
      type: json['type'] ??"",
  desc: json['desc']??"" ,
  dateTime: json['dateTime']

  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageCover": imageCover,
        "images": images,
        "sizes": sizes,
        "colors": colors,
        "madeBy": madeBy,
        "rate": rate,
        "count": count,
        "price": price,
        "category": category,
        "sale": sale,
        "type": type ,
         "desc"  : desc ,
    "dateTime":dateTime
      };
}
