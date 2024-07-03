import '../../Auth/data/model/user_model.dart';

abstract class ProfileState {}
class ProfileStateInitial extends ProfileState{}




class  ProfileInfoSuccess extends ProfileState{
  final UserModel profileInfo ;
  ProfileInfoSuccess({required this.profileInfo});

}
class  ProfileInfoLoading extends ProfileState{


}
class  ProfileInfoFailure extends ProfileState{
  final  String errorMessage ;
  ProfileInfoFailure({required this.errorMessage});
}

