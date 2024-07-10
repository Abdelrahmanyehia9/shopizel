import '../data/promo_model.dart';

abstract class PromoState {}
class PromoCodeInitial extends PromoState{}

class GetAllPromoSuccess extends PromoState{
  final List<PromoModel> allPromo ;

  GetAllPromoSuccess({required this.allPromo});
}
class GetAllPromoFailure extends PromoState{}
class GetAllPromoLoading extends PromoState{}



class ApplyPromoSuccess extends PromoState{
  final PromoModel promoModel  ;
  final double discount ;
  ApplyPromoSuccess({required this.promoModel , required this.discount});

}
class ApplyPromoFailure extends PromoState{
  final String errorMessage ;
  ApplyPromoFailure({required this.errorMessage});
}
class ApplyPromoLoading extends PromoState{}
