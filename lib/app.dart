
import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'login/login_screen.dart';
import 'package:quan_ly_chi_tieu/router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GlobalLoaderOverlay(
          overlayColor: Colors.black,
          overlayOpacity: 0.7,
          child: MaterialApp(
            theme: ThemeData(
                primaryColor: AppColors.appColor
            ),
            debugShowCheckedModeBanner: false,
            home: const LoginScreen(),
            onGenerateRoute: onGenerateRoute,
          ),
        ),
    );
  }
}
