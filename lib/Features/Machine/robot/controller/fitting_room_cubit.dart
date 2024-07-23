import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Machine/robot/controller/fitting_room_state.dart';

import '../data/fitting_room_repo.dart';

class FittingRoomCubit extends Cubit<FittingRoomState>{
  final FittingRoomRepo repo ;
  FittingRoomCubit(this.repo):super(FittingRoomStateInitial()) ;


Future<void> fitModel({required String modelImg , required String clothesImg})async {
  emit(FittingRoomStateLoading()) ;
  try{
    String? img  = await repo.fetch(humanImg: modelImg, clothImg: clothesImg) ;
    print(img) ;
    if (img == null ){
      emit(FittingRoomStateFailure(errorMessage: "Oops there was an error , please try again "))  ;
    }else{
      emit(FittingRoomStateSuccess(img: img)) ;
    }

  }catch (e){
    emit(FittingRoomStateFailure(errorMessage: e.toString())) ;

  }






}


}