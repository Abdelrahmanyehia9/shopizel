import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/profile/controller/profile_state.dart';

import '../../Auth/data/model/user_model.dart';
import '../data/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileRepo repo  ;
  UserModel profile  = UserModel(uid: "", email: "example@gmail.com" , number: "0123456789")  ;
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

}