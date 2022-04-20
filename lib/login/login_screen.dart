
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quan_ly_chi_tieu/bloc/login_bloc/login_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/login_bloc/login_event.dart';
import 'package:quan_ly_chi_tieu/bloc/login_bloc/login_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state){
            if    (state is LoginLoadingState) {
              print('Đang load');

            }
            else if (state is LoginSuccessState) {

              Navigator.pushNamed(context, Constants.homeScreen,
                     arguments: _emailController.text);
            }
            else if (state is LoginErrorState) {

                        print(state.error);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset('image2.png'),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    "Chào mừng bạn",
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                const Text(
                  "Đăng nhập để sửa dụng Quản lý chi tiêu",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 15,
                  ),
                  child: TextField(

                    controller: _emailController,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Nhập email",
                      prefixIcon: const SizedBox(
                        width: 5,
                        child: Icon(Icons.email),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Color(0xffCED0D2), width: 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                  ),
                ),
                TextField(
                  controller: _passController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Nhập mật khẩu",
                    prefixIcon: const SizedBox(
                      width: 5,
                      child: Icon(Icons.lock),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffced0d2),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.loose(
                    const Size(double.infinity, 40),
                  ),
                  alignment: AlignmentDirectional.centerEnd,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, Constants.forgotPasswordScreen);
                          },
                        text: "Quên mật khẩu ?",
                        style: AppThemes.lightText,
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      color: AppColors.appColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(LoginAddEvent(email: _emailController.text.trim(), password:_passController.text.trim(),),);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    child: const Text(
                      "Đăng ký",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: AppColors.appColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Constants.registerScreen);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

