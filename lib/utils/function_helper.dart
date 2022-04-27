import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FunctionHelper {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
  static DateTime formatDateText(String text) {
    return DateFormat("yyyy-MM-dd").parse(text);
  }
  static String formatDateHour(DateTime dateTime) {
    return DateFormat('kk:mm a').format(dateTime);
  }
  static String formatDateYearMonthDay(DateTime dateTime){
    return DateFormat('yyyy-MM-dd - kk:mm').format(dateTime);
  }

  static Future<dynamic> showSnackBar({
    required BuildContext context,
    required String title,
    Color? color,
  }) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
        ),
        backgroundColor: color,
      ),
    );
  }
  static Future<dynamic> selectDate(
      {required BuildContext context,
        DateTime? initialDate,
        DateTime? firstDate,
        DateTime? lastDate}) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1970),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 20),
    );
  }


  static bool isSameDate(DateTime date1, DateTime date2) {
    return date2.year == date1.year &&
        date2.month == date1.month &&
        date2.day == date1.day;
  }

  static messFirebase(string) {
    if(string == '[firebase_auth/invalid-email] The email address is badly formatted.'){
      return 'Email không chích xác';
    }else if(string == '[firebase_auth/unknown] Given String is empty or null'){
      return 'không được để trống';
    } return 'Không tìm thấy tài khoản';
  }

  static String  convertErrorToMess(err){
    switch(err.toString()){

      case '[firebase_auth/unknown] Given String is empty or null' :
        return 'Bạn đang để trống mật khẩu';
      case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
        return 'Tài khoản của bạn có thể đã bị xoá';
      case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
        return 'Sai mật khẩu';
      case "[firebase_auth/weak-password] Password should be at least 6 characters" :
        return "Mật khẩu mới ít nhất 6 ký tự";
      case '[firebase_auth/invalid-email] The email address is badly formatted.' :
        return "Email phải đúng định dạng";
      case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
        return 'Email đã tồn tại';
      case 'user-not-found' :
        return 'Không tìm thấy email đăng nhập';
      case 'wrong-password':
        return 'Sai mật khẩu';
      case 'invalid-email' :
        return 'Sai dinh dang email';
      default : return '';
    }
  }
}