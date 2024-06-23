import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/home/controllers/gender_state.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';
import 'package:shoppizel/Features/home/data/repository/home_repo.dart';
import 'package:shoppizel/Features/home/data/repository/store_repo.dart';

class GenderCubit extends Cubit<GenderState>{

  GenderCubit(this.repo ):super(GenderStateInitial()) ;
   final HomeRepo repo  ;

  Future<void> fetch ( String gender)async {

    emit(GenderStateLoading()) ;
        try{
          List<String> cat =[] ;
                   List<ProductModel> collection = await repo.getAllProduct(gender) ;
                   for(int i = 0 ; i<collection.length ; i++ ){
                    cat.add(collection[i].type)  ;
                   }


                   emit(GenderStateSuccess(collection: collection , cat: cat)) ;

        }catch(e){

          emit(GenderStateFailure()) ;

        }












  }





}