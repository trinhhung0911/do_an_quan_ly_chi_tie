import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 30,right: 30),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset('image2.png'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: Text("Chào mừng bạn",
                  style: TextStyle(fontSize: 30,color: Color(0xff333333)),
                ),
              ),
              const Text("Đăng nhập để sửa dụng Quản lý chi tiêu",
                style: TextStyle(fontSize: 18,color: Color(0xff606470)),),
              Padding(
                padding: const EdgeInsets.only(top: 50,bottom: 15),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(fontSize: 16,color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "Nhập email",
                      prefixIcon: const SizedBox(
                        width: 5,child: Icon(Icons.email),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffCED0D2),width: 0),
                          borderRadius: BorderRadius.circular(10))
                      )
                  ),
                ),
              TextField(
                controller: _passController,
                style: const TextStyle(fontSize: 16,color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Nhập mật khẩu",
                    prefixIcon: const SizedBox(
                      width: 5,child: Icon(Icons.lock),
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffced0d2),width: 0),
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                      },
                      child: const Icon(Icons.visibility),
                    ),
                  )
                    )
                ),
              Container(
                constraints: BoxConstraints.loose(Size(double.infinity,40)),
                alignment: AlignmentDirectional.centerEnd,
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Quên mật khẩu ?",style: TextStyle(fontSize: 16,color: Color(0xff606470)),),
                ),

              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30,bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      child: const Text("Đăng nhập",style: TextStyle(color: Colors.white,fontSize: 18),),
                      color: AppColors.appColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      onPressed: (){
                        if(_emailController.text=='hung09112000@gmail.com'&&_passController.text=='123123')
                        {
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        }
                        else
                        {
                          showAlertDialog(context);
                        }
                      },
                    ),
                  )
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  child: const Text("Đăng ký",style: TextStyle(color: Colors.white,fontSize: 18),),
                  color: AppColors.appColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  onPressed: (){
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Simple Alert"),
    content: Text("Check the information again"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}