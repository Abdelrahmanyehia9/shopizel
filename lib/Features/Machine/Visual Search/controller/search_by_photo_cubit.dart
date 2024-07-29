import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/controller/search_by_photo_states.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/data/model/visual_search_model.dart';
import 'package:shoppizel/Features/Machine/Visual%20Search/data/repository/search_by_photo_repo.dart';
import 'package:shoppizel/Features/home/data/model/product_model.dart';

import '../../../../core/service/gimini.dart';

class SearchByPhotoCubit extends Cubit<SearchByPhotoStates> {
  final SearchByPhotoRepo repo;

  SearchByPhotoCubit(this.repo) : super(SearchByPhotoStateInitial());

  Future<void> fetch({required File image}) async {
    emit(SearchByPhotoLoading());
    try {
      String? desc = await geminiTextAndPhoto(image: image ,text: "description  keywords, please mention the color " );
      if (desc == null) {
        emit(SearchByPhotoStateFailure(
            errorMessage: "Please enter valid Image"));
        return;
      } else {
        List<VisualSearchModel>? predict = await repo.search(desc);
        if (predict == null) {
          emit(SearchByPhotoStateFailure(
              errorMessage:
                  "The Photo you have applied doesn't  match any product"));
        } else {
          List<ProductModel> products = await repo.productSearch(predict);
          emit(SearchByPhotoStateSuccess(
              predicted: predict, products: products));
        }
      }
    } catch (e) {
      emit(SearchByPhotoStateFailure(errorMessage: e.toString()));
    }
  }
}
