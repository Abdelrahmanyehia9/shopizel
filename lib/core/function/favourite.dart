import 'package:shoppizel/Features/home/data/model/product_model.dart';

import '../../Features/Favourite/data/repository/favourite_repository.dart';

class Favourite {



  static favHandler(bool isFav , ProductModel model)async{
    if(isFav){
      await FavouriteRepo().removeFromFavourite(id: model.id) ;
    }else{
      await FavouriteRepo().addToFavourite(model: model) ;
    }


  }









}