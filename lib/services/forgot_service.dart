import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';
import 'package:quan_ly_chi_tieu/utils/encryption_manager.dart';

class ForgotService{
  Future<dynamic> forgotPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<dynamic> updatePassword(
      {required String currentPassword, required String newPassword}) async {

    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(email: user!.email!, password: currentPassword);
    var id = await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference employeeCollection = FirebaseFirestore.instance.collection(CollectionName.users.name);
    await user.reauthenticateWithCredential(cred);
    await user.updatePassword(newPassword);
    await employeeCollection.doc(id).update({"password": newPassword});
  }

}