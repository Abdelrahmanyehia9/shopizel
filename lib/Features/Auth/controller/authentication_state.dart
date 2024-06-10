import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginSuccess extends SignUpState{
final  UserCredential credential ;
LoginSuccess({required this.credential}) ;

}
class LoginFailure extends SignUpState {

  final String errorCode ;
  LoginFailure({required this.errorCode}) ;
}
class LoginLoading extends SignUpState{

}
class LoginInitial extends SignUpState{}





/// sign up States
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