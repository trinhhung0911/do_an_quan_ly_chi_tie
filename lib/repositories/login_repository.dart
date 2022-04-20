import 'package:quan_ly_chi_tieu/services/login_service.dart';

class LoginRepository{
  Future<dynamic> loginWithEmail({required String email, required String password}) async {
    await LoginService().loginWithEmail(email: email, password: password);
  }
}