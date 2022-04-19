import 'package:flutter/material.dart';
import '../../../configs/colors.dart';
import '../../../configs/constants.dart';
import '../../Components/home_components/drawer_item_card.dart';
import '../../home_screen.dart';
class DanhMucChiScreen extends StatefulWidget {
  const DanhMucChiScreen({Key? key}) : super(key: key);
  @override
  _DanhMucChiScreenState createState() => _DanhMucChiScreenState();
}
class _DanhMucChiScreenState extends State<DanhMucChiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Danh mục chi'),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Constants.addTypeSpendScreen);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor:AppColors.appColor,
        heroTag: "btn_dmct",
      ),
      drawer:  DrawerItem(email: HomeScreen.email,),
    );
  }
}
