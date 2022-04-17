import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';

class AppThemes{
  final BuildContext context;
  AppThemes(this.context);
  static TextStyle lightText = const TextStyle(color: Color(0xff327708),fontSize: 16);
  static TextStyle moneyText =const TextStyle(color: AppColors.textColor,fontSize: 25);
}