abstract class  FittingRoomState{}
class FittingRoomStateInitial extends FittingRoomState {}
class FittingRoomStateSuccess extends FittingRoomState {
  final String img ;
  FittingRoomStateSuccess({required this.img});

}
class FittingRoomStateLoading extends FittingRoomState {}
class FittingRoomStateFailure extends FittingRoomState {
  final String errorMessage  ;
  FittingRoomStateFailure({required this.errorMessage});

}