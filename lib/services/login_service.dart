import 'package:firebase_auth/firebase_auth.dart';

class LoginService{
    Future<UserCredential> loginWithEmail({required String email, required String password}) async {
      await FirebaseAuth.instance.signOut();
      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
  }
}