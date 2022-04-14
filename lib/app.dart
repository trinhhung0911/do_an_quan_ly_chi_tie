
import 'package:flutter/material.dart';
import 'login/login_screen.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.teal
          ),
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
        )

    );
  }
}
