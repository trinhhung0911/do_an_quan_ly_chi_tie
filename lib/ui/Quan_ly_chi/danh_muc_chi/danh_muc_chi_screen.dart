import 'package:flutter/material.dart';
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
        title: const Text('Danh mục chi'),
      ),
    );
  }
}
