import 'package:shoppizel/Features/Machine/robot/data/model/generate_outfit_model.dart';
import 'package:shoppizel/core/database/api_helper.dart';

class GenerateOutfitRepo {
  final ApiHelper helper;

  GenerateOutfitRepo(this.helper);

  Future<GenerateOutfitModel?> fetch(Input input) async {
    var response = await helper.post(
        "/predict_fashion", input.toJson(), "application/json");
print(response) ;
    if(response != null ){
      return GenerateOutfitModel.fromJson(response) ;
    }else{
      return null ;
    }
  }
}
