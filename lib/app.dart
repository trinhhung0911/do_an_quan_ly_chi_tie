
import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';

import 'package:quan_ly_chi_tieu/router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quan_ly_chi_tieu/ui/login/login_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
            home: AnimatedSplashScreen(
              duration: 2000,
                splash:const Text('Quản lý chi tiêu',style:  TextStyle(fontSize: 20,color: AppColors.appColor),),
              nextScreen: const LoginScreen(),
              splashTransition: SplashTransition.rotationTransition,
            ),
            onGenerateRoute: onGenerateRoute,
          ),
        ),
    );
  }
}
