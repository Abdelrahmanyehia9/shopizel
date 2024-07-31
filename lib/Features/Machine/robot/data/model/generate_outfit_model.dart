class GenerateOutfitModel {
  String? id;
  String? model;
  String? version;
  Input? input;
  String? logs;
  List<String>? output;
  bool? dataRemoved;
  String? status;
  String? createdAt;
  String? startedAt;
  String? completedAt;
  Metrics? metrics;

  GenerateOutfitModel(
      {this.id,
        this.model,
        this.version,
        this.input,
        this.logs,
        this.output,
        this.dataRemoved,
        this.status,
        this.createdAt,
        this.startedAt,
        this.completedAt,
        this.metrics});

  GenerateOutfitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    version = json['version'];
    logs = json['logs'];
    output = json['output'].cast<String>();
    dataRemoved = json['data_removed'];
    status = json['status'];
    createdAt = json['created_at'];
    startedAt = json['started_at'];
    input = json['input'] != null ? Input.fromJson(json['input']) : null;
    completedAt = json['completed_at'];
    metrics = json['metrics'] != null ? Metrics.fromJson(json['metrics']) : null;
  }

}

class Input {
  String? clothing;
  String? image;
  String? prompt;

  Input({this.clothing, this.image, this.prompt});

 factory Input.fromJson(Map<String , dynamic>json){
   return Input(
     image: json["image"] ,
     prompt: json["prompt"] ,
     clothing: json['clothing']
   ) ;
 }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clothing'] = clothing;
    data['image'] = image;
    data['prompt'] = prompt;
    return data;
  }
}


class Metrics {
  double? predictTime;

  Metrics({this.predictTime});

  Metrics.fromJson(Map<String, dynamic> json) {
    predictTime = json['predict_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['predict_time'] = this.predictTime;
    return data;
  }
}
