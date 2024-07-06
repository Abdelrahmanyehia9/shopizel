import '../data/model.dart';

abstract class LocationStates{}
class LocationStateInitial extends LocationStates {}






class AddLocationStateLoading extends LocationStates {}
class AddLocationStateSuccess extends LocationStates {}
class AddLocationStateFailure extends LocationStates {
  final String error ;

  AddLocationStateFailure({required this.error});
}



class GetLocationsStateLoading extends LocationStates {}
class GetLocationsStateSuccess extends LocationStates {
  List<LocationModel> locations   ;
 final LocationModel? selectedLocation ;
 GetLocationsStateSuccess({required this.locations ,  this.selectedLocation});
}
class GetLocationsStateFailure extends LocationStates {
  final String error ;

  GetLocationsStateFailure({required this.error});
}



class DeleteLocationStateLoading extends LocationStates {}
class DeleteLocationStateSuccess extends LocationStates {}
class DeleteLocationStateFailure extends LocationStates {
  final String error ;
  DeleteLocationStateFailure({required this.error});
}