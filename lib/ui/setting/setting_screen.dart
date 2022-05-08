import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  static List<String> listColor= [
    'Tất cả',
    'Tuần này',
    'Tháng này',
    'Năm này',
  ];
  static String dropDownValue = listColor[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt"),
        centerTitle: true,
        backgroundColor: AppColors.appColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20,left: 24,right: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Thiết lập màu sắc',style:AppThemes.commonText ,),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20
                  ),
                  height: 40,
                  width: 180,
                  decoration: const BoxDecoration(
                    color: AppColors.boxColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropDownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: listColor.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Center(child: Text(items)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(
                              () {
                           dropDownValue = newValue!;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Thiết lập ngôn ngữ',style:AppThemes.commonText ,),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  height: 40,
                  width: 180,
                  decoration: const BoxDecoration(
                    color: AppColors.boxColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropDownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: listColor.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Center(child: Text(items)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(
                              () {
                            dropDownValue = newValue!;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Đơn vị tiền tệ ',style:AppThemes.commonText ,),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  height: 40,
                  width: 180,
                  decoration: const BoxDecoration(
                    color: AppColors.boxColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropDownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: listColor.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Center(child: Text(items)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(
                              () {
                            dropDownValue = newValue!;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                child: const Text(
                  "Đồng bộ dữ liệu ",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                color:AppColors.appColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ), onPressed: () {
                  setState(() {
                   // AppColors.appColor=Color(0xFF208990);
                  });

              },
              ),
            )
          ],

        ),

      ),
      drawer: DrawerItem(
        email: HomeScreen.email,
      ),
    );
  }
}
