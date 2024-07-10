import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/promo/data/promo_model.dart';
import 'package:shoppizel/Features/promo/controller/promo_state.dart';

import '../data/promo_code_repo.dart';

class PromoCubit extends Cubit<PromoState>{
  final PromoCodeRepo repo   ;
  PromoCubit(this.repo) :super(PromoCodeInitial());


  Future <void> getAllPromo()async{
    emit(GetAllPromoLoading()) ;
    try{
      List<PromoModel> allPromo = await repo.getAllPromo() ;

      emit(GetAllPromoSuccess(allPromo: allPromo)) ;


    }catch(e){
      emit(GetAllPromoFailure()) ;
      print(e) ;
    }





  }




}