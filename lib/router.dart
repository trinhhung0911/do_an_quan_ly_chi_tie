import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/ui/login/change_password_screen.dart';
import 'package:quan_ly_chi_tieu/ui/login/forgot_password_screen.dart';
import 'package:quan_ly_chi_tieu/ui/login/login_screen.dart';
import 'package:quan_ly_chi_tieu/ui/login/register_screen.dart';
import 'package:quan_ly_chi_tieu/ui/manage_collect/collect_screen.dart';
import 'package:quan_ly_chi_tieu/ui/manage_collect/manage_collect/add_cost_collect_screen.dart';
import 'package:quan_ly_chi_tieu/ui/manage_spend/spend_screen.dart';
import 'package:quan_ly_chi_tieu/ui/setting/setting_screen.dart';
import 'ui/manage_collect/category_collect/add_category_collect_screen.dart';
import 'ui/manage_spend/category_spend/add_category_spend_screen.dart';
import 'ui/manage_spend/manage_spend/add_cost_spend_screen.dart';


Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case Constants.forgotPasswordScreen:
      return generateRouter(screen: const ForgotPasswordScreen() );
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
    case Constants.collectScreen:
      return generateRouter(screen: const CollectScreen());
    case Constants.addCategoryCollectScreen:
      return generateRouter(screen:  AddCategoryCollectScreen(arg: args,));
    case Constants.addCostCollectScreen:
      return generateRouter(screen:  AddCostCollectScreen(arg: args,));
    case Constants.settingScreen:
      return generateRouter(screen: const SettingScreen());
    default:
      throw ('This route name does not exit');
  }
}
generateRouter({required Widget screen}) {
  return MaterialPageRoute(builder: (context) => screen);
}