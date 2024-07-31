import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/profile/controller/profile_state.dart';

import '../../Auth/data/model/user_model.dart';
import '../data/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState>{


  late UserModel profile ;
  ProfileRepo repo  ;
  ProfileCubit(this.repo):super(ProfileStateInitial()) ;

  Future<void> fetchProfile() async{
    emit(ProfileInfoLoading()) ;
    try{
     UserModel model = await repo.getProfileInfo() ;
     profile = model ;
      emit(ProfileInfoSuccess(profileInfo: model)) ;

    }catch(e){
      emit(ProfileInfoFailure(errorMessage: e.toString())) ;
    }

}
  Future<void>editProfile(UserModel user , File? img)async{
    emit(EditProfileInfoLoading()) ;
    try{
     await repo.editProfile(user) ;
     if (img != null ){
     await repo.updateImg(image: img) ;
     }
      emit(EditProfileInfoSuccess()) ;

    }catch(e){
      emit(EditProfileInfoFailure(errorMessage: e.toString())) ;
    }






  }

}