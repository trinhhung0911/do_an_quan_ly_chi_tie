import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'Components/drawer_item_card.dart';

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
      ),
      body: Container(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => const NewTransactionPage()),);
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
