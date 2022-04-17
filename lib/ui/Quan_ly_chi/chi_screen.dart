import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/ui/Quan_ly_chi/danh_muc_chi/danh_muc_chi_screen.dart';
import 'package:quan_ly_chi_tieu/ui/Quan_ly_chi/quan_l%C3%BD_chi/quan_ly_chi_screen.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';

import '../Components/home_components/drawer_item_card.dart';
class SpendScreen extends StatefulWidget {
  const SpendScreen({Key? key}) : super(key: key);
  @override
  _SpendScreenState createState() => _SpendScreenState();
}
class _SpendScreenState extends State<SpendScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions=[
    const QuanLyChiScreen(),
    const DanhMucChiScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: IndexedStack(
        children: _widgetOptions,
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon:Icon( Icons.money,color: _selectedIndex == 0 ? Colors.white : Colors.black,),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.margin,
              color: _selectedIndex == 1 ? Colors.white : Colors.black,
            ),
            label: "",
          ),

        ],
        backgroundColor: AppColors.appColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        iconSize: 24,
        onTap: _onItemTapped,
        elevation: 1,
        unselectedFontSize: 0,
        selectedFontSize: 0,
      ),
    );
  }
}
