import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpState {}

class SignUpSuccess extends SignUpState{
  final  UserCredential credential ;
  SignUpSuccess({required this.credential}) ;

}
class SignUpFailure extends SignUpState {

  final String errorCode ;
  SignUpFailure({required this.errorCode}) ;
}
class SignUpLoading extends SignUpState{

}
class SignUpInitial extends SignUpState{}