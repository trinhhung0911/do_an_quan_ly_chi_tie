import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import '../configs/themes.dart';
import 'Components/home_components/drawer_item_card.dart';
import 'Components/home_components/money_home.dart';

class HomeScreen extends StatefulWidget {
  final dynamic arg;
  const HomeScreen({Key? key, this.arg}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Trang Chủ'),),
        centerTitle: true,
      ),
      body:Column(
        children: const <Widget>[
          MoneyHome(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor:AppColors.appColor),
      drawer:  DrawerItem(email: widget.arg,),
    );
  }
}
