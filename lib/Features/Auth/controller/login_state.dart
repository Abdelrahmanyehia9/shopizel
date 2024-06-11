import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginSuccess extends LoginState{
final  UserCredential? credential ;
LoginSuccess({ this.credential}) ;

}
class LoginFailure extends LoginState {

  final String errorCode ;
  LoginFailure({required this.errorCode}) ;
}
class LoginLoading extends LoginState{

}
class LoginInitial extends LoginState{}





