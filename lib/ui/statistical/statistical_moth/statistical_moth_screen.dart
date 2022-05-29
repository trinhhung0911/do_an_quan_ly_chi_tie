import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/app_data.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/group_by.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticalMothScreen extends StatefulWidget {
  const StatisticalMothScreen({Key? key}) : super(key: key);
  @override
  _StatisticalMothScreenState createState() => _StatisticalMothScreenState();
}

class _StatisticalMothScreenState extends State<StatisticalMothScreen>  {
  static List<String> items = ['Biểu đồ tròn', 'Biểu đồ cột'];
  late String dropDownValueOverview;
  late String dropDownValueSpend;
  late String dropDownValueCollect;
  late TooltipBehavior _tooltipBehavior;
  bool overview = true;
  bool spend = true;
  bool collect = true;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    dropDownValueOverview = items[0];
    dropDownValueSpend = items[0];
    dropDownValueCollect = items[0];
    // TODO: implement initState
    super.initState();
  }

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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 24, left: 24),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Tổng quan', style: AppThemes.commonText),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: AppThemes.commonText.copyWith(color: Colors.black),
                      value: dropDownValueOverview,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(
                              () {
                            dropDownValueOverview = newValue!;
                            if (dropDownValueOverview.compareTo(items[0]) ==
                                0) {
                              overview = true;
                            }
                            if (dropDownValueOverview.compareTo(items[1]) ==
                                0) {
                              overview = false;
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              overview == true
                  ? SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries<GroupBy, String>>[
                    // Initialize line series
                    PieSeries<GroupBy, String>(
                      dataSource: AppData.sumCollectSpend,
                      xValueMapper: (GroupBy sales, _) => sales.name,
                      yValueMapper: (GroupBy sales, _) => sales.money,
                      name: 'Số tiền',
                      dataLabelSettings:
                      const DataLabelSettings(isVisible: true),
                    )
                  ])
                  : SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                NumericAxis(minimum: 0, maximum: double.parse(AppData.groupSpend.first.money.toString()), interval: 10),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries<GroupBy, String>>[
                  ColumnSeries<GroupBy, String>(
                    dataSource: AppData.sumCollectSpend,
                    xValueMapper: (GroupBy sales, _) => sales.name,
                    yValueMapper: (GroupBy sales, _) => sales.money,
                    name: 'Số tiền',
                    dataLabelSettings:
                    const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    color: AppColors.appColor,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Tình hình ', style: AppThemes.commonText),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: AppThemes.commonText.copyWith(color: Colors.black),
                      value: dropDownValueSpend,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(
                              () {
                            dropDownValueSpend = newValue!;
                            if (dropDownValueSpend.compareTo(items[0]) == 0) {
                              spend = true;
                            }
                            if (dropDownValueSpend.compareTo(items[1]) == 0) {
                              spend = false;
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: spend == true
                        ? SfCircularChart(
                        legend: Legend(
                          title: LegendTitle(
                            text: 'Tình hình chi',
                            textStyle: const TextStyle(
                                fontSize: 14,

                                fontWeight: FontWeight.w900),),
                          isVisible: true,
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.scroll,
                        ),
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries<GroupBy, String>>[
                          // Initialize line series
                          PieSeries<GroupBy, String>(
                            dataSource: AppData.groupSpend,
                            xValueMapper: (GroupBy sales, _) =>
                            sales.name,
                            yValueMapper: (GroupBy sales, _) =>
                            sales.money,
                            name: 'Số tiền',
                            dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                          )
                        ])
                        : SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                          minimum: 0, maximum: 40, interval: 10),
                      tooltipBehavior: _tooltipBehavior,
                      series: <ChartSeries<GroupBy, String>>[
                        ColumnSeries<GroupBy, String>(
                          dataSource: AppData.groupSpend,
                          xValueMapper: (GroupBy sales, _) => sales.name,
                          yValueMapper: (GroupBy sales, _) => sales.money,
                          name: 'Số tiền',
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          color: AppColors.appColor,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: spend == true
                        ? SfCircularChart(
                        legend: Legend(
                          title: LegendTitle(
                              text:'Tình hinhg thu',
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900
                              )
                          ),
                          isVisible: true,
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.scroll,
                        ),
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries<GroupBy, String>>[
                          PieSeries<GroupBy, String>(
                            dataSource: AppData.groupCollect,
                            xValueMapper: (GroupBy sales, _) =>
                            sales.name,
                            yValueMapper: (GroupBy sales, _) =>
                            sales.money,
                            name: 'Số tiền',
                            dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                          )
                        ])
                        : SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                          minimum: 0, maximum: 40, interval: 10),
                      tooltipBehavior: _tooltipBehavior,
                      series: <ChartSeries<GroupBy, String>>[
                        ColumnSeries<GroupBy, String>(
                          dataSource: AppData.groupCollect,
                          xValueMapper: (GroupBy sales, _) => sales.name,
                          yValueMapper: (GroupBy sales, _) => sales.money,
                          name: 'Số tiền',
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          color: AppColors.appColor,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
