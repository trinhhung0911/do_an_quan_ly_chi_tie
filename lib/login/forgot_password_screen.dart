import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Quên mật khẩu'),
        backgroundColor: AppColors.appColor,
        automaticallyImplyLeading: false,
        titleSpacing: 24,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset('image2.png'),
              ),
              Container(
                padding: const EdgeInsets.only(right: 16,left: 16),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.forgotColor
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Quên mật khẩu",
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
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
                    SizedBox(
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10,left: 16,right: 16),
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
                      Navigator.pushNamed(context, Constants.loginScreen);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
