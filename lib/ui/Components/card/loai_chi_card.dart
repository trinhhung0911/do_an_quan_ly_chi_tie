import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/loai_chi.dart';

class TypeSpendCard extends StatefulWidget {
  LoaiChi loaiChi;
  int index;
  TypeSpendCard(this.loaiChi, this.index, {Key? key}) : super(key: key);

  @override
  _TypeSpendCardState createState() => _TypeSpendCardState();
}
class _TypeSpendCardState extends State<TypeSpendCard> {

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        decoration:  BoxDecoration(
          color: AppColors.spendCardColor,
          borderRadius: BorderRadius.circular(10)
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 16,top: 8,bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.account_circle_outlined,size: 40,),
            const SizedBox(width: 30,),
            Text(widget.loaiChi.name,style: AppThemes.commonText,)
          ],
        ),
      );


  }
}