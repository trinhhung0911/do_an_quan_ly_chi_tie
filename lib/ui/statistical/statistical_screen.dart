import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/ui/statistical/statistical_day/statistical_day_screen.dart';
import 'package:quan_ly_chi_tieu/ui/statistical/statistical_moth/statistical_moth_screen.dart';

import 'statistical_option/statistical_option_screen.dart';
import 'statistical_year/statistical_year_screen.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({Key? key}) : super(key: key);
  @override
  _StatisticalScreenState createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appColor,
          appBar: AppBar(
            title: const Text('Thống kê'),
            centerTitle: true,
            backgroundColor: AppColors.appColor,
          ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DefaultTabController(
                length: 4,
                child:Column(
                  children:  [
                    TabBar(
                      tabs: [
                        Text('Ngày này',style: AppThemes.commonText,),
                        Text('Tháng này',style: AppThemes.commonText,),
                        Text('Năm này',style: AppThemes.commonText,),
                        Text('Tùy chọn',style: AppThemes.commonText,)
                      ],
                      isScrollable: true,
                        indicatorColor:Colors.black
                    ),
                     const Expanded(
                      child: TabBarView(children: [
                       StatisticalDayScreen(),
                        StatisticalMothScreen(),
                        StatisticalYearScreen(),
                        StatisticalOptionScreen(),
                      ],
                      ),
                    )
                  ],
                ) ,

              ),
            ),
          drawer: DrawerItem(
          email: HomeScreen.email,
        ),
        )
    );
  }
}
