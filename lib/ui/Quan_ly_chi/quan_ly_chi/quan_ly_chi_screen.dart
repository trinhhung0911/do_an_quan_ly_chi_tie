import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/input/input_search.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';

class QuanLyChiScreen extends StatefulWidget {
  const QuanLyChiScreen({Key? key}) : super(key: key);
  @override
  _QuanLyChiScreenState createState() => _QuanLyChiScreenState();
}

class _QuanLyChiScreenState extends State<QuanLyChiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Quản lý chi'),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child:  Column(
          children: [
            InputSearch(searchNameEmployee),
            // ListView.builder(
            //   padding: EdgeInsets.only(
            //       left: 24, right: 24, top: 20),
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   primary: false,
            //   itemCount: empEmployee.length,
            //   scrollDirection: Axis.vertical,
            //   itemBuilder: (context, index) => EmployeeCard(
            //     index,
            //     empEmployee[index],
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Constants.addSpendScreen);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor:AppColors.appColor,
        heroTag: "btn_qlct",
      ),
      drawer:  DrawerItem(email: HomeScreen.email,),
    );
  }
  searchNameEmployee(String query) {}
}
