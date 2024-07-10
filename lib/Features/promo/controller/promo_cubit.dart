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
  Future<void> applyPromo(String promoCode)async{
    emit(ApplyPromoLoading()) ;
    try{
   PromoModel? model = await   repo.applyPromo(promoCode);
   if(model != null ){
     if(DateTime.now().isAfter(DateTime.parse(model.validation))){
       emit(ApplyPromoFailure(errorMessage: "code ${model.code.toUpperCase()} has been expired ")) ;
     } else{
         emit(ApplyPromoSuccess(promoModel: model , discount: double.parse(model.discount??"0"))) ;
     }

   }else{

     emit(ApplyPromoFailure(errorMessage: "$promoCode is not exist , try different one")) ;

   }

    }catch(e){
      emit(ApplyPromoFailure(errorMessage: e.toString())) ;
    }


  }
  void removePromo(){
    emit(PromoCodeInitial()) ;
  }



}