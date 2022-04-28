import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
class ManageCollectScreen extends StatefulWidget {
  const ManageCollectScreen({Key? key}) : super(key: key);
  @override
  _ManageCollectScreenState createState() => _ManageCollectScreenState();
}

class _ManageCollectScreenState extends State<ManageCollectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(
          child: Text('Quản lý thu'),
        ),
        centerTitle: true,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.appColor,
        heroTag: "btn_1",
      ),
      drawer: DrawerItem(
        email: HomeScreen.email,
      ),
    );
  }
}
