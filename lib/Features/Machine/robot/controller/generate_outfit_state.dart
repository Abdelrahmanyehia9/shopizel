import 'package:shoppizel/Features/Machine/robot/data/model/generate_outfit_model.dart';

abstract class GenerateOutfitState {}
class GenerateOutfitStateInitial extends GenerateOutfitState{}
class GenerateOutfitStateSuccess extends GenerateOutfitState{
  final GenerateOutfitModel model ;
  GenerateOutfitStateSuccess({required this.model});
}
class GenerateOutfitStateFailure extends GenerateOutfitState{
  final String error ;
  GenerateOutfitStateFailure({required this.error});

}
class GenerateOutfitStateLoading extends GenerateOutfitState{}
