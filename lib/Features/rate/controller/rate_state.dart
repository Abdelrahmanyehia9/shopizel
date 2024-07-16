import '../data/rate_model.dart';

abstract class RateState{}
class RateStateInitial extends RateState{}




class AddRateSuccess extends RateState {}
class AddRateFailure extends RateState{
  final String error;
  AddRateFailure({required this.error});

}
class AddRateLoading extends RateState{}




class GetAllRatesLoading extends RateState{}
class GetAllRatesSuccess extends RateState{
  final List<RateModel> rates  ;
  GetAllRatesSuccess({required this.rates});
}
class GetAllRatesFailure extends RateState{
  final String error ;
  GetAllRatesFailure({required this.error});

}


class GetProductRateLoading extends RateState {}
class GetProductRateFailure extends RateState {}
class GetProductRateSuccess extends RateState {
  final List<RateModel> rates ;

  GetProductRateSuccess({required this.rates});
}


