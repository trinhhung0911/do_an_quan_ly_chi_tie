import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';
import 'package:quan_ly_chi_tieu/services/login_service.dart';

import '../configs/constants.dart';
import '../storage/secure_storge.dart';
class LoginRepository{
  Future<dynamic> loginWithEmail({required String email, required String password}) async {
    // đăng nhập
    var res = await  LoginService().loginWithEmail(email: email, password: password);
    // Lưu vào stoge
    var userId = res.user!.uid;
    var emailUser = res.user!.email;
    var existedIdUser = await FirebaseFirestore.instance.collection(CollectionName.users.name).where('uId', isEqualTo: userId).get();
    await SecureStorage().saveString(
      key: SecureStorage.userId,
      value: existedIdUser.docs[0].id,
    );



  }
}