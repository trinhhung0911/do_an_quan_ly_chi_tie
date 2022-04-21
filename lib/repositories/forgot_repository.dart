

import 'package:quan_ly_chi_tieu/services/forgot_service.dart';

class ForgotRepository{
  Future<dynamic> forgotPassword({required String email}) async {
    await ForgotService().forgotPassword(email: email);
  }

}