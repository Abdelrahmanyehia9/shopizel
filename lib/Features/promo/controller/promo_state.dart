import '../data/promo_model.dart';

abstract class PromoState {}
class PromoCodeInitial extends PromoState{}

class GetAllPromoSuccess extends PromoState{
  final List<PromoModel> allPromo ;

  GetAllPromoSuccess({required this.allPromo});
}
class GetAllPromoFailure extends PromoState{}
class GetAllPromoLoading extends PromoState{}
