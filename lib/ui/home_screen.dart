import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/chart_collection.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/status_collection.dart';
import 'Components/home_components/drawer_item_card.dart';
import 'Components/home_components/money_home.dart';

class HomeScreen extends StatefulWidget {
  final dynamic arg;
  static String email='';
  const HomeScreen({Key? key, this.arg}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
   HomeScreen.email=widget.arg;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Trang chủ'),),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            MoneyHome(),
            StatusCollection(),
            ChartCollection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Constants.spendScreen);
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
