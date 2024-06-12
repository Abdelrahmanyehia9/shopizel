import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Auth/controller/sign_up_state.dart';
import 'package:shoppizel/Features/Auth/data/model/user_model.dart';
import 'package:shoppizel/core/database/firebase_constant.dart';

class SignUpCubit extends Cubit<SignUpState>{
  SignUpCubit():super(SignUpInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance ;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance ;
  /// Signup using email  and password
  Future<void> signUpByEmailAndPassword(String name, String email , String password)async{
    late String error ;
    emit(SignUpLoading()) ;
    try{
      final  credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
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


}