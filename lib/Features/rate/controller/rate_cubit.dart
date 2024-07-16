import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/rate/controller/rate_state.dart';
import 'package:shoppizel/Features/rate/data/rate_repo.dart';

import '../data/rate_model.dart';

class RateCubit extends Cubit<RateState>{
  final RateRepo repo ;

  RateCubit({required this.repo}) :super(RateStateInitial());
  Future<void>addNewRate(List<RateModel> rates)async{
    emit(AddRateLoading()) ;
    try{
      await repo.addRating(rates) ;

      emit(AddRateSuccess()) ;

    }catch(e){
      emit(AddRateFailure(error: e.toString())) ;
    }





  }
  Future<void>getMyRates()async{
    emit(GetAllRatesLoading()) ;
    try{
      List<RateModel>myRates = await repo.getAllMyRates() ;
      emit(GetAllRatesSuccess(rates: myRates)) ;

    }catch(e){
      emit(GetAllRatesFailure(error: e.toString())) ;
    }




  }
  Future<void> getProductRate(ProductModel model)async{
    emit(GetProductRateLoading());
    try{
      List<RateModel> rates = await repo.getProductRate(model);
      emit(GetProductRateSuccess(rates: rates)) ;

    }catch(e){
      emit(GetAllRatesFailure(error: e.toString())) ;
    }


}



}
