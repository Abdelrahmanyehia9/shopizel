import 'package:shoppizel/Features/home/data/model/product_model.dart';

import '../../Features/Favourite/data/repository/favourite_repository.dart';

class Favourite {
  static  FavouriteRepo repo  = FavouriteRepo() ;
  static favHandler(bool isFav, ProductModel model) async {
    if (isFav) {
      await repo.removeFromFavourite(id: model.id);
    } else {
      await repo.addToFavourite(model: model);
    }


  }
}
