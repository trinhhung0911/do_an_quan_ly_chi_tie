import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/app_data.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/models/get_statistical.dart';
import 'package:quan_ly_chi_tieu/models/group_by.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticalYearScreen extends StatefulWidget {
  GetStatistical ?getStatistical;
   StatisticalYearScreen({this.getStatistical});
  @override
  _StatisticalYearScreenState createState() => _StatisticalYearScreenState();
}

class _StatisticalYearScreenState extends State<StatisticalYearScreen> {
  static List<String> items = ['Biểu đồ tròn', 'Biểu đồ cột'];
  late String dropDownValueOverview;
  late String dropDownValueSpend;
  late String dropDownValueCollect;
  late TooltipBehavior _tooltipBehavior1;
  late TooltipBehavior _tooltipBehavior2;
  late TooltipBehavior _tooltipBehavior3;
  bool overview = true;
  bool spend = true;
  bool collect = true;
  late int last;
  late int now;

  @override
  void initState() {
    _tooltipBehavior1 = TooltipBehavior(enable: true);
    _tooltipBehavior2 = TooltipBehavior(enable: true);
    _tooltipBehavior3 = TooltipBehavior(enable: true);
    dropDownValueOverview = items[0];
    dropDownValueSpend = items[0];
    dropDownValueCollect = items[0];
    last = widget.getStatistical!.sumLastYear ?? 0;
    now = widget.getStatistical!.sumYear ?? 0;
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
              last > now
                  ? Text('Năm nay chi tiêu ít hơn năm trước',
                  style: AppThemes.commonText.copyWith(
                    color: AppColors.appColor,
                  ))
                  : Text('Năm nay chi tiêu nhiều hơn năm trước',
                  style: AppThemes.commonText.copyWith(color: Colors.red)),
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
                  tooltipBehavior: _tooltipBehavior1,
                  series: <CircularSeries<GroupBy, String>>[
                    // Initialize line series
                    PieSeries<GroupBy, String>(
                      dataSource:widget.getStatistical!.groupSumSpendCollectYear,
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
                NumericAxis(
                    minimum: 0,
                    maximum:double.parse(widget.getStatistical!.groupSumSpendCollectYear![0].money.toString())+
                        double.parse(widget.getStatistical!.groupSumSpendCollectYear![1].money.toString()),
                    interval: 10),
                tooltipBehavior: _tooltipBehavior1,
                series: <ChartSeries<GroupBy, String>>[
                  ColumnSeries<GroupBy, String>(
                    dataSource: widget.getStatistical!.groupSumSpendCollectYear??AppData.sumCollectSpend,
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
                        tooltipBehavior: _tooltipBehavior2,
                        series: <CircularSeries<GroupBy, String>>[
                          // Initialize line series
                          PieSeries<GroupBy, String>(
                            dataSource: widget.getStatistical!.groupBySpendYear,
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
                          minimum: 0, maximum: double.parse(widget.getStatistical!.groupSumSpendCollectYear![1].money.toString()), interval: 10),
                      tooltipBehavior: _tooltipBehavior2,
                      series: <ChartSeries<GroupBy, String>>[
                        ColumnSeries<GroupBy, String>(
                          dataSource: widget.getStatistical!.groupBySpendYear??AppData.sumCollectSpend,
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
                              text:'Tình hình thu',
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900
                              )
                          ),
                          isVisible: true,
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.scroll,
                        ),
                        tooltipBehavior: _tooltipBehavior3,
                        series: <CircularSeries<GroupBy, String>>[
                          PieSeries<GroupBy, String>(
                            dataSource: widget.getStatistical!.groupByCollectYear,
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
                          minimum: 0, maximum: double.parse(widget.getStatistical!.groupSumSpendCollectYear![0].money.toString()), interval: 10),
                      tooltipBehavior: _tooltipBehavior3,
                      series: <ChartSeries<GroupBy, String>>[
                        ColumnSeries<GroupBy, String>(
                          dataSource: widget.getStatistical!.groupByCollectYear??AppData.sumCollectSpend,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
