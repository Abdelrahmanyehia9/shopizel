import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Machine/robot/controller/generate_outfit_state.dart';

import '../data/model/generate_outfit_model.dart';
import '../data/repo/generate_outfit_repo.dart';

class GenerateOutfitCubit extends Cubit<GenerateOutfitState>{
 final  GenerateOutfitRepo repo ;
  GenerateOutfitCubit(this.repo):super(GenerateOutfitStateInitial()) ;




  Future<void> generate(Input input)async{
    emit( GenerateOutfitStateLoading()) ;
    try{
       GenerateOutfitModel? model = await repo.fetch(input) ;
       if(model != null ) {
         emit(GenerateOutfitStateSuccess(model: model));
       }else{
         emit(GenerateOutfitStateFailure(error: "oops , there was an error , try again later")) ;
       }


    }catch(e){
      emit(GenerateOutfitStateFailure(error: e.toString())) ;
    }



  }
void returnToDefult(){
    emit(GenerateOutfitStateInitial()) ;
}











}