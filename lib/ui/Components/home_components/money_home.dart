import 'package:flutter/material.dart';

import '../../../configs/colors.dart';
import '../../../configs/themes.dart';
class MoneyHome extends StatefulWidget {
  const MoneyHome({Key? key}) : super(key: key);

  @override
  _MoneyHomeState createState() => _MoneyHomeState();
}

class _MoneyHomeState extends State<MoneyHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 24,left: 24,top: 20,bottom: 20),
      color:AppColors.appColor,
      width: double.infinity,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: AppColors.appColor,
              child: Icon(
                Icons.attach_money,
                size: 30,
                color:Colors.white,
              ),
            ),
            Text(
              '10.000.000',
              style: AppThemes.moneyText,),
            InkWell(
              onTap: (){
              },
              child: const Icon(
                Icons.add,
                size: 30,
                color: AppColors.appColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
