import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/login/login_screen.dart';
import 'package:quan_ly_chi_tieu/login/register_screen.dart';
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
    default:
      throw ('This route name does not exit');
  }
}

generateRouter({required Widget screen}) {
  return MaterialPageRoute(builder: (context) => screen);
}