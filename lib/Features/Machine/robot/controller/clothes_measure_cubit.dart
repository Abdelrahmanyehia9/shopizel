import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Machine/robot/controller/clothes_measure_state.dart';

import '../data/model/clothes_measure_model.dart';
import '../data/repo/clothes_measure_repo.dart';

class ClothesMeasureCubit extends Cubit<ClothesMeasureState>{

  ClothesMeasureRepo repo ;
  ClothesMeasureCubit(this.repo):super(ClothesMeasureStateInitial()) ;


Future<void>getMeasure({required String img, double? height })async{
  emit(ClothesMeasureStateLoading()) ;

  try{

    ClothesMeasureModel? model = await repo.measure(img: img , height: height ?? 175 ) ;
    if ( model != null ){
      emit(ClothesMeasureStateSuccess(measureModel: model)) ;
    }else{
      emit(ClothesMeasureStateFailure(errorMessage: "Oops , there was an error , please try again later")) ;
    }

  }catch (e){
    emit(ClothesMeasureStateFailure(errorMessage: e.toString())) ;
  }




}



}