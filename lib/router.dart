import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/login/login_screen.dart';
import 'package:quan_ly_chi_tieu/login/register_screen.dart';
import 'package:quan_ly_chi_tieu/login/change_password_screen.dart';

import 'package:quan_ly_chi_tieu/ui/Quan_ly_chi/spend_screen.dart';
import 'package:quan_ly_chi_tieu/ui/Quan_ly_chi/danh_muc_chi/add_category_spend_screen.dart';
import 'package:quan_ly_chi_tieu/ui/Quan_ly_chi/quan_ly_chi/add_cost_spend_screen.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'login/forgot_password_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case Constants.forgotPasswordScreen:
      return generateRouter(screen: const ForgotPasswordScreen());
    case Constants.loginScreen:
      return generateRouter(screen: const LoginScreen());
    case Constants.homeScreen:
      return generateRouter(screen: HomeScreen(arg: args,));
    case Constants.registerScreen:
      return generateRouter(screen: const RegisterScreen());
    case Constants.spendScreen:
      return generateRouter(screen: const SpendScreen());
    case Constants.addSpendScreen:
      return generateRouter(screen: AddSpendScreen(arg: args,));
    case Constants.addTypeSpendScreen:
      return generateRouter(screen: AddTypeSpendScreen(arg: args,));
    case Constants.changePasswordScreen:
      return generateRouter(screen: const ChangePasswordScreen());
    default:
      throw ('This route name does not exit');
  }
}
generateRouter({required Widget screen}) {
  return MaterialPageRoute(builder: (context) => screen);
}