import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/app_data.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/loai_chi_card.dart';
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
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(left: 24, right: 24),
                physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: AppData.listLoaiChi.length,
              itemBuilder: (context, index) =>TypeSpendCard(AppData.listLoaiChi[index],index)
            ),
          ],
        ),
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
        heroTag: "btn_1",
      ),
      drawer:  DrawerItem(email: HomeScreen.email,),
    );
  }
}
