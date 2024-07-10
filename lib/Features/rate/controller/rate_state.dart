abstract class RateState{}
class RateStateInitial extends RateState{}




class AddRateSuccess extends RateState {}
class AddRateFailure extends RateState{
  final String error;
  AddRateFailure({required this.error});

}
class AddRateLoading extends RateState{}