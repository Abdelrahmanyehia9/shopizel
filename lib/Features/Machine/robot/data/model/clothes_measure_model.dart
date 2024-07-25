class ClothesMeasureModel {



  final double chestWidth ;
  final double armWidth ;
  final double frontLength ;
  final double sleeveLength ;
  final double score ;
  final String sizeValue ;

  ClothesMeasureModel(
      {required this.chestWidth,
      required this.armWidth,
      required this.frontLength,
      required this.sleeveLength,
      required this.score,
      required this.sizeValue});

  factory ClothesMeasureModel.fromJson(Map<String, dynamic> json) =>
      ClothesMeasureModel(
          chestWidth: json["chest_width"],
          armWidth: json["arm_width"],
          frontLength: json["front_length"],
          sleeveLength: json["sleeve_length"],
          score: json["score"],
          sizeValue: json["size"]);
}