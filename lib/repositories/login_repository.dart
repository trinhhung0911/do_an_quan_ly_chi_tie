import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/services/login_service.dart';

class LoginRepository{
  Future<dynamic> loginWithEmail({required String email, required String password}) async {
    var res = await  LoginService().loginWithEmail(email: email, password: password);
  }
}