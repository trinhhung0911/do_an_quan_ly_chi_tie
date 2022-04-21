import 'package:firebase_auth/firebase_auth.dart';

class ForgotService{
  Future<dynamic> forgotPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

}