import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/rate/controller/rate_state.dart';
import 'package:shoppizel/Features/rate/data/rate_repo.dart';

import '../data/rate_model.dart';

class RateCubit extends Cubit<RateState>{
  final RateRepo repo ;

  RateCubit({required this.repo}) :super(RateStateInitial());


  Future<void>addNewRate(List<RateModel> rates)async{
    emit(AddRateLoading()) ;
    try{
      repo.addRating(rates) ;
      emit(AddRateSuccess()) ;


    }catch(e){
      emit(AddRateFailure(error: e.toString())) ;
    }





  }




}
