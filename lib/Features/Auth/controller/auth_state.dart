import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class LoginSuccess extends AuthState{
final  UserCredential? credential ;
LoginSuccess({ this.credential}) ;

}
class LoginFailure extends AuthState {

  final String errorCode ;
  LoginFailure({required this.errorCode}) ;
}
class LoginLoading extends AuthState{

}
class LoginInitial extends AuthState{}
class SignUpSuccess extends AuthState{
  final  UserCredential credential ;
  SignUpSuccess({required this.credential}) ;

}
class SignUpFailure extends AuthState {

  final String errorCode ;
  SignUpFailure({required this.errorCode}) ;
}
class SignUpLoading extends AuthState{

}
class SignUpInitial extends AuthState{}





