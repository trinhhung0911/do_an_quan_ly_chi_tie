import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
class MoneyHome extends StatelessWidget {
   int sumMoney;
   MoneyHome({Key? key,required this.sumMoney}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 24,left: 24,top: 10,bottom: 10),
      color:AppColors.appColor,
      width: double.infinity,
      child: Container(
        width: double.infinity,
        height: 50,
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
             sumMoney!=null? sumMoney.toString():'0',
              style: AppThemes.moneyText,),
            InkWell(
              onTap: () async {

                Navigator.pushNamed(context, Constants.addCostCollectScreen);
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
