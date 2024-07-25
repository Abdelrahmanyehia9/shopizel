import 'package:shoppizel/Features/Machine/robot/data/model/clothes_measure_model.dart';

abstract class ClothesMeasureState {}
class ClothesMeasureStateInitial extends ClothesMeasureState{}
class ClothesMeasureStateSuccess extends ClothesMeasureState{
  final ClothesMeasureModel measureModel ;

  ClothesMeasureStateSuccess({required this.measureModel});
}
class ClothesMeasureStateFailure extends ClothesMeasureState{
  final String errorMessage  ;
  ClothesMeasureStateFailure({required this.errorMessage});

}
class ClothesMeasureStateLoading extends ClothesMeasureState{}