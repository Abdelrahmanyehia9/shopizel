 import 'package:firebase_auth/firebase_auth.dart';

abstract class SocialMediaAuth{

   Future<UserCredential> faceBook() ;
   Future<UserCredential> twitter() ;
   Future<UserCredential> apple() ;


}