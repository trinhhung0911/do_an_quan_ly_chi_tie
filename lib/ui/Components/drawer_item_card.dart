import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
class DrawerItem extends StatefulWidget {
  String email;
  DrawerItem({Key? key,required this.email}) : super(key: key);

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text("Quản Lý Chi Tiêu"),
            accountEmail: Text(widget.email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                "H",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home), title: const Text("Trang Chủ"),
            onTap: () {
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_sharp),
            title: const Text("Quản Lý Thu"),
            onTap: () {
             // Navigator.push(context, MaterialPageRoute(builder: (context)=> const ManagementCollect()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_photo_alternate_outlined),
            title: const Text("Quản Lý Chi"),
            onTap: () {
             // Navigator.push(context, MaterialPageRoute(builder: (context)=> const ManagementSpend()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text("Thống Kê"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text("Danh sách tài khoản"),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>const ListAccount()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspaces_filled),
            title: const Text("Đổi Mật Khẩu"),
            onTap: () {
             Navigator.pushNamed(context, Constants.loginScreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back),
            title: const Text("Thoát"),
            onTap: () {
             Navigator.pushNamed(context, Constants.loginScreen);
            },
          ),
        ],
      ),
    );
  }
}
