import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('image2.png'),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Chào mừng bạn",
                  style: TextStyle(fontSize: 30, color: AppColors.textColor),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
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
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffCED0D2),
                        width: 0,
                      ),
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
                  prefixIcon: const Icon(Icons.lock),
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
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
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
                        print('Đăng ký thành công');
                      },
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                alignment: AlignmentDirectional.centerEnd,
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, Constants.homeScreen,
                              arguments: 'hung09112000@gmail.com');
                        },
                      text: "Đăng nhập ngay ?",
                      style: AppThemes.lightText,
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
