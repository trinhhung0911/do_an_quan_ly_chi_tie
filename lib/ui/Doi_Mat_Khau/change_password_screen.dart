
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/forgot_bloc/forgot_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/forgot_bloc/forgot_event.dart';
import 'package:quan_ly_chi_tieu/bloc/forgot_bloc/forgot_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}


class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();
  bool passwordVisible = true;
  bool newPasswordVisible = true;
  bool retypePasswordVisible = true;
  bool  validatePassWord=true;
  String errorPassWordText='';
  FocusNode newPasswordFocus = FocusNode();
  late Users users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
        backgroundColor: AppColors.appColor,
        centerTitle: true,
      ),
      body: BlocListener<ForgotBloc, ForgotState>(
        listener: (context, state) {
          if (state is UpdatePasswordLoadingState) {
         //   LoadingHelper.showLoading(context);
            print('Đang load');
          }
          else if (state is UpdatePasswordSuccessState) {
            print('Thành công');
         //   LoadingHelper.hideLoading(context);
         //    FunctionHelper.showSnackBar(
         //      context: context,
         //      title: "Đổi mật khẩu thành công",
         //    );
          }
          else if (state is UpdatePasswordErrorState) {
            print('Thất bại');
            // LoadingHelper.hideLoading(context);
             FunctionHelper.showSnackBar(context: context, title: state.error);
            print(state.error);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 24,
            right: 24,
          ),
          child: Column(
            children: [
              TextField(
                controller: _oldPasswordController,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                obscureText: passwordVisible ? true : false,
                decoration: InputDecoration(
                  labelText: "Mật khẩu cũ ",
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
                    child:  Icon(
                      passwordVisible == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),


              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: TextField(
                  focusNode: newPasswordFocus,
                  controller: _newPasswordController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                   obscureText: newPasswordVisible ? true : false,
                  decoration: InputDecoration(
                      errorText: validatePassWord == true ? null : errorPassWordText,
                    labelText: "Nhập mật khẩu mới",
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
                            newPasswordVisible=!newPasswordVisible;
                          },
                        );
                      },
                      child:Icon(
                        newPasswordVisible == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: _retypePasswordController,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  obscureText: retypePasswordVisible ? true : false,
                  decoration: InputDecoration(
                    labelText: "Xác mật khẩu mới",
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
                                retypePasswordVisible=! retypePasswordVisible;
                          },
                        );
                      },
                      child: Icon(
                        retypePasswordVisible == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  child: const Text(
                    "Đổi mật khẩu ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color:AppColors.appColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), onPressed: () {
                    if(_checkEmptyPassword()==true){
                      if(_checkNewPassword()==true){
                        if(validatePassWord==true) {
                          BlocProvider.of<ForgotBloc>(context).add(
                            UpdatePasswordEvent(
                              currentPassword: _oldPasswordController.text
                                  .trim(),
                              newPassword: _newPasswordController.text
                                  .trim(),),);
                        }
                        else{
                          FunctionHelper.showSnackBar(context: context, title: 'Password phải trên 6 ký tự !');
                          FocusScope.of(context).requestFocus(newPasswordFocus);
                        }
                      }
                      else{
                        FunctionHelper.showSnackBar(context: context, title:'Mật khẩu chưa trùng nhau !');
                        _newPasswordController.clear();
                        _retypePasswordController.clear();
                        FocusScope.of(context).requestFocus(newPasswordFocus);
                      }
                    }else{
                      FunctionHelper.showSnackBar(context: context, title: 'Bạn cần nhập đầy đủ thông tin !');
                    }
                },
                ),
              )
            ],
          ),
        ),
      ),
      drawer: DrawerItem(
        email: HomeScreen.email,
      ),
    );
  }
  _checkNewPassword() {
    if(_newPasswordController.text.trim()==_retypePasswordController.text.trim()){
      return true;
    }
    return false;

  }
  _checkEmptyPassword(){
    if(_newPasswordController.text.trim().isEmpty||
  _retypePasswordController.text.trim().isEmpty||
  _oldPasswordController.text.trim().isEmpty){
      return false;
  }
    return true;

}
}
