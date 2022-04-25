

import 'package:quan_ly_chi_tieu/services/forgot_service.dart';

class ForgotRepository{
  Future<dynamic> forgotPassword({required String email}) async {
    await ForgotService().forgotPassword(email: email);
  }
  Future<dynamic> updatePassword({required String currentPassword, required String newPassword}) async {
    await ForgotService().updatePassword(
        currentPassword: currentPassword, newPassword: newPassword);
  }


}