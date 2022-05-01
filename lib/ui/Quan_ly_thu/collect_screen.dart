import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/ui/Quan_ly_thu/danh_muc_thu/category_collect_screen.dart';
import 'package:quan_ly_chi_tieu/ui/Quan_ly_thu/quan_ly_thu/manage_collect_screenn.dart';
class CollectScreen extends StatefulWidget {
  const CollectScreen({Key? key}) : super(key: key);
  @override
  _CollectScreenState createState() => _CollectScreenState();
}

class _CollectScreenState extends State<CollectScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions=[
    const ManageCollectScreen(),
    const CategoryCollectScreen(),
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
            icon:Icon(
              Icons.money,color: _selectedIndex == 0 ? Colors.white : Colors.black,),
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
