import 'package:flutter/material.dart';

class StatisticalOptionScreen extends StatefulWidget {
  const StatisticalOptionScreen({Key? key}) : super(key: key);

  @override
  _StatisticalOptionScreenState createState() => _StatisticalOptionScreenState();
}

class _StatisticalOptionScreenState extends State<StatisticalOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(child: Text("Đang cập nhật!",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
    );
  }
}
