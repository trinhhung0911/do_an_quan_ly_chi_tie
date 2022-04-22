import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
class AddTypeSpendScreen extends StatefulWidget {

  const AddTypeSpendScreen({Key? key}) : super(key: key);
  @override
  _AddTypeSpendScreenState createState() => _AddTypeSpendScreenState();
}

class _AddTypeSpendScreenState extends State<AddTypeSpendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Thêm danh mục chi'),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 24,right: 24),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:TextField(
                style:AppThemes.commonText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.workspaces_outline,size: 30,) ,
                  hintText: 'Tên danh mục ',
                  hintStyle:AppThemes.commonText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:TextField(

                style:AppThemes.commonText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.notes,size: 30,) ,
                  hintText: 'Hạn mức ',
                  hintStyle:AppThemes.commonText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:TextField(
                style:AppThemes.commonText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.notes,size: 30,) ,
                  hintText: 'Chú thích',
                  hintStyle:AppThemes.commonText,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
             margin: EdgeInsets.only(top: 20),
              child: FlatButton(
                color: AppColors.appColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.arrow_circle_down_sharp,
                      size: 28,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Tạo',
                    ),
                  ],
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onPressed:(){
                  print('Thêm thành công');
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}

