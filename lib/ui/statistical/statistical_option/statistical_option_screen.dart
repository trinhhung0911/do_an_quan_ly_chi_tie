import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_option_bloc/statistical_option_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_option_bloc/statistical_option_event.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_option_bloc/statistical_option_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class StatisticalOptionScreen extends StatefulWidget {
  const StatisticalOptionScreen({Key? key}) : super(key: key);

  @override
  _StatisticalOptionScreenState createState() =>
      _StatisticalOptionScreenState();
}

class _StatisticalOptionScreenState extends State<StatisticalOptionScreen> {
  TextEditingController dayController = TextEditingController();
  TextEditingController mothController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  List<CostSpend> costSpend = [];
  List<CostCollect> costCollect = [];
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      child: TextField(
                        controller: dayController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Ngày",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffCED0D2),
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: mothController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Tháng",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffCED0D2),
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: yearController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Năm",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffCED0D2),
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<StatisticalOptionBloc>(context).add(
                          GetStatisticalOptionEvent(
                            day: int.parse(dayController.text.toString().length == 0
                                ? DateTime.now().day.toString()
                                : dayController.text.toString()),
                            moth: int.parse(
                                mothController.text.toString().length == 0
                                    ? DateTime.now().month.toString()
                                    : mothController.text.toString()),
                            year: int.parse(
                                yearController.text.toString().length == 0
                                    ? DateTime.now().year.toString()
                                    : yearController.text.toString()),
                          ),
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.appColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Tìm',
                            style: AppThemes.commonText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Khoản chi',
                          style: AppThemes.commonText,
                        ),
                        SizedBox(height: 40,),
                         Center(child: Text('Chưa có dữ liệu !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),))
                      ],
                    ),
                    SizedBox(height: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Khoản thu',
                          style: AppThemes.commonText,
                        ),
                        SizedBox(height: 40,),
                        Center(child: Text('Chưa có dữ liệu !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),))
                      ],
                    ),
                  ],
                )
              ],
            ))
    );





  }
}
