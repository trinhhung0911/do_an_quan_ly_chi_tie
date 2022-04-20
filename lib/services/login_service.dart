import 'package:firebase_auth/firebase_auth.dart';

class LoginService{
    Future<dynamic> loginWithEmail({required String email, required String password}) async {

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

  }
}