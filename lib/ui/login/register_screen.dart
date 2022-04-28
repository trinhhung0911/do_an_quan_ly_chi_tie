import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_event.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';
import 'package:quan_ly_chi_tieu/utils/encryption_manager.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import 'package:quan_ly_chi_tieu/utils/validate_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  bool validateEmail = true;
  String errorEmailText = '';

  bool validatePassWord = true;
  String errorPassWordText = '';

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appColor,
        title: const Text('Đăng ký'),
        titleSpacing: 24,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is CreateUserLoadingState) {
              LoadingHelper.showLoading(context);
            } else if (state is CreateUserSuccessState) {
              LoadingHelper.hideLoading(context);
              FunctionHelper.showSnackBar(
                  context: context, title: 'Đăng ký thành công !');
              refresh();
            } else if (state is CreateUserErrorState) {
              LoadingHelper.hideLoading(context);
              FunctionHelper.showSnackBar(context: context, title: state.error);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset('image2.png'),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Chào mừng bạn",
                    style: TextStyle(fontSize: 30, color: AppColors.textColor),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Đăng ký để sửa dụng Quản lý chi tiêu",
                    style: TextStyle(fontSize: 16, color: AppColors.textColor),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Nhập tên",
                    prefixIcon: const Icon(Icons.accessibility),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffCED0D2),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                        borderSide: const BorderSide(
                            color: Color(0xffCED0D2), width: 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorText: validateEmail == true ? null : errorEmailText,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        if (Validate.isEmail(value) == false) {
                          validateEmail = false;
                        } else {
                          validateEmail = true;
                        }
                        if (value.isEmpty) {
                          errorEmailText = 'Nhập email';
                        } else {
                          errorEmailText = 'Nhập đúng định dạng email !';
                        }
                      });
                    },
                  ),
                ),
                TextField(
                  controller: _passController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  obscureText: passwordVisible ? true : false,
                  decoration: InputDecoration(
                      labelText: "Nhập mật khẩu",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xffced0d2),
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                        child: Icon(
                          passwordVisible == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      errorText:
                          validatePassWord == true ? null : errorPassWordText),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                      if (value.length <= 6) {
                        validatePassWord = false;
                      } else {
                        validatePassWord = true;
                      }
                      if (value.isEmpty) {
                        errorPassWordText = 'Nhập mật khẩu !';
                      } else {
                        errorPassWordText = 'Mật khẩu phải trên 6 ký tự !';
                      }
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: TextField(
                    controller: _confirmPassController,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    obscureText: confirmPasswordVisible ? true : false,
                    decoration: InputDecoration(
                      labelText: "Xác nhận mật khẩu",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xffced0d2),
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(
                            () {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            },
                          );
                        },
                        child: Icon(
                          confirmPasswordVisible == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _confirmPassword = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    child: const Text(
                      "Đăng ký",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: AppColors.appColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      if (validatePassWord == true &&
                          validateEmail == true &&
                          _email.isNotEmpty &&
                          _password.isNotEmpty &&
                          _password.trim() == _confirmPassword.trim()) {
                        var user = Users(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password:  _passController.text.trim(),
                            startDate: DateTime.now());
                        BlocProvider.of<UserBloc>(context).add(
                          CreateUserEvent(users: user),
                        );

                      }
                      if (_email.isEmpty ||
                          _password.isEmpty ||
                          _confirmPassword.isEmpty) {
                        FunctionHelper.showSnackBar(
                            context: context, title: 'Nhập đầy đủ thông tin !');
                      }
                      if (_password.trim() != _confirmPassword.trim() &&
                          _password.isNotEmpty &&
                          _confirmPassword.isNotEmpty) {
                        FunctionHelper.showSnackBar(
                            context: context,
                            title: 'Mật khẩu chưa trùng nhau !');
                      }
                    },
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
                            Navigator.pushNamed(
                              context,
                              Constants.loginScreen,
                            );
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

  void refresh() {
    setState(() {
      _emailController.clear();
      _nameController.clear();
      _passController.clear();
      _confirmPassController.clear();
      passwordVisible = true;
      confirmPasswordVisible = true;
      validateEmail = true;
      errorEmailText = '';
      validatePassWord = true;
      errorPassWordText = '';
      _email = '';
      _password = '';
      _confirmPassword = '';
    });
  }
}
