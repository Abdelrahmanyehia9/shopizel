import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/location/controller/location_states.dart';

import '../data/location_repo.dart';
import '../data/model.dart';

class LocationCubit extends Cubit<LocationStates>{

  LocationRepo repo  ;

  LocationCubit(this.repo):super(LocationStateInitial()) ;


  Future<void> addLocation(LocationModel model)async{

    emit(AddLocationStateLoading()) ;
    try{
     await  repo.addToLocation(model) ;

      emit(AddLocationStateSuccess()) ;

    }catch(e){
      emit(AddLocationStateFailure(error: "Failed To add Location , please Try again Later")) ;

    }


  }



}