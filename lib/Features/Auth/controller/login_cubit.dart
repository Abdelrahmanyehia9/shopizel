import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppizel/Features/Auth/controller/login_state.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
