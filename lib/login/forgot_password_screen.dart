import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import 'package:quan_ly_chi_tieu/utils/validate_helper.dart';

import '../bloc/forgot_bloc/forgot_bloc.dart';
import '../bloc/forgot_bloc/forgot_event.dart';
import '../bloc/forgot_bloc/forgot_state.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool validateEmail = true;
  bool passwordVisible = true;
  String errorText='Nhập đúng định dạng email !';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Quên mật khẩu'),
        backgroundColor: AppColors.appColor,
        titleSpacing: 24,
        automaticallyImplyLeading: false,

      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child:  BlocListener<ForgotBloc, ForgotState>(
          listener: (context, state) {
            if (state is ForgotLoadingState) {
             LoadingHelper.showLoading(context);
            } else if (state is ForgotSuccessState) {
              LoadingHelper.hideLoading(context);
              FunctionHelper.showSnackBar(context: context, title: 'Kiểm tra email của bạn để đặt mật khẩu mới');
              _emailController.clear();
             Navigator.pushNamed(context, Constants.loginScreen);
            } else if (state is ForgotErrorState) {
              LoadingHelper.hideLoading(context);
              FunctionHelper.showSnackBar(context: context, title: state.error);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset('image2.png'),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 16,left: 16),
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.forgotColor
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 20,
                        ),
                        child: Text(
                          "Quên mật khẩu",
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Nhập email",
                          prefixIcon: const SizedBox(
                            width: 5,
                            child: Icon(Icons.email),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xffCED0D2), width: 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: validateEmail==true?null:errorText,
                        ),
                        onChanged: (value){
                          setState(() {
                            if(Validate.isEmail(value)==false){
                              validateEmail=false;
                            }else{
                              validateEmail=true;
                            }
                            if(value.isEmpty){
                              errorText='Nhập email';
                            }else{
                              errorText='Nhập đúng định dạng email';
                            }
                          });
                        },

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: FlatButton(
                            child: const Text(
                              "Gửi",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            color: AppColors.appColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if(validateEmail == true && _emailController.text.isNotEmpty){
                                BlocProvider.of<ForgotBloc>(context).add(ForgotPasswordEvent(email: _emailController.text.trim()));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: AlignmentDirectional.centerEnd,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, Constants.loginScreen,);
                          },
                        text: "Đăng nhập ?",
                        style: AppThemes.lightText,
                      )
                    ]),
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
