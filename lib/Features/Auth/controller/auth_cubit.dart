import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Auth/controller/auth_state.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoppizel/core/database/local/shared_prefrences.dart';

import '../../../core/database/remote/firebase_constant.dart';
import '../data/model/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore =FirebaseFirestore.instance;

  /// Signup using email  and password
  Future<void> loginByEmailAndPassword(String email, String password) async {
    late String error;
    emit(LoginLoading());
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess(credential: credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        error = "Account has been blocked try another account";
      } else if (e.code == "invalid-credential") {
        error = "wrong password , try again later";
      } else if (e.code == 'too-many-requests') {
        error = "too many requests please try later ";
      } else if (e.code == 'network-request-failed') {
        error = "network error , check your connection";
      } else {
        // Handle other errors
        error = e.code.toString();
      }
    } catch (e) {
      error = 'Unexpected Error: $e';
    }
    emit(LoginFailure(errorCode: error));
  }
  ///sign up
  Future<void> signUpByEmailAndPassword(String name, String email , String password)async{
    late String error ;
    emit(SignUpLoading()) ;
    try{

      final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(name.split(" ").first) ;


      if(credential.user != null){
        UserModel user = UserModel(uid: credential.user!.uid, email: email , username: name)  ;
        await _fireStore.collection(FirebaseConstant.usersCollection).doc(credential.user!.uid).set(user.toJson()) ;
        emit(SignUpSuccess(credential: credential)) ;
      }
    }
    on FirebaseAuthException catch (e) {

      if (e.code == 'user-disabled') {
        error = "Account has been blocked try another account" ;
      }
      else if (e.code == ("email-already-in-use")){
        error = "Email Already in use , try another one"  ;
      }
      else if (e.code == 'user-not-found') {
        error = "there are no user of $email" ;
      }

      else if (e.code == 'too-many-requests') {
        error = "too many requests please try later " ;
      }
      else if (e.code == 'network-request-failed') {
        error = "network error , check your connection" ;
      }
      else{
        error = 'Unexpected Error : ${e.code}' ;
        print (e.code) ;
      }

    }

    emit(SignUpFailure(errorCode: error));

  }
  /// facebook
  Future<void> signInWithFacebook() async {
    emit(LoginLoading());
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential credential =
          await _auth.signInWithCredential(facebookAuthCredential);
      emit(LoginSuccess(credential: credential));
    } catch (e) {
      emit(LoginFailure(errorCode: "Error has occurred try again later"));
    }
  }
///google
  Future<void> signInWithGoogle() async {
    try {
      emit(LoginLoading());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      emit(LoginSuccess(credential: userCredential));
    } catch (e) {
      emit(LoginFailure(errorCode: "Error has occurred try again later"));
    }
  }

  Future<void>signOut()async{
  await _auth.signOut() ;
  }
}
