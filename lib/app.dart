
import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'login/login_screen.dart';
import 'package:quan_ly_chi_tieu/router.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: AppColors.appColor
          ),
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
          onGenerateRoute: onGenerateRoute,
        ),
    );
  }
}
