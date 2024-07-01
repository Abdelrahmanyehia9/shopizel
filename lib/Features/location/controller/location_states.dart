abstract class LocationStates{}
class LocationStateInitial extends LocationStates {}






class AddLocationStateLoading extends LocationStates {}
class AddLocationStateSuccess extends LocationStates {}
class AddLocationStateFailure extends LocationStates {
  final String error ;

  AddLocationStateFailure({required this.error});
}
