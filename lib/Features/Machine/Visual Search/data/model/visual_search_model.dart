class VisualSearchModel {
  final dynamic docId;
  final dynamic simScore;

  VisualSearchModel({required this.docId, required this.simScore});

  factory VisualSearchModel.fromJson(Map<String, dynamic> json) =>
      VisualSearchModel(
          docId: json['document_id'], simScore: json["similarity_score"]);
}
