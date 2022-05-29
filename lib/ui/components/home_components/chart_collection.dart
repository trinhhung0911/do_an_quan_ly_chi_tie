import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/models/group_by.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../configs/themes.dart';

class ChartCollection extends StatefulWidget {
  List<GroupBy>? groupBySpendAll = [];
  List<GroupBy>? groupBySpendDay = [];
  List<GroupBy>? groupBySpendMoth = [];
  List<GroupBy>? groupBySpendYear = [];
  List<GroupBy>? groupBySpendNull = [];

  ChartCollection(
      {this.groupBySpendAll,
      this.groupBySpendDay,
      this.groupBySpendMoth,
      this.groupBySpendYear,
      this.groupBySpendNull});
  @override
  _ChartCollectionState createState() => _ChartCollectionState();
}

class _ChartCollectionState extends State<ChartCollection> {
  static List<String> items = ["Tất cả", "Ngày nay", "Tháng này", "Năm nay"];
  late String dropDownValue;
  List<GroupBy>? groupBySpend = [];
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    dropDownValue = items[0];
    widget.groupBySpendAll == null
        ? groupBySpend = widget.groupBySpendNull
        : groupBySpend = widget.groupBySpendAll;
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
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 24, left: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Biểu đồ chi', style: AppThemes.commonText),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    style: AppThemes.commonText.copyWith(color: Colors.black),
                    value: dropDownValue,
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
                          dropDownValue = newValue!;
                          if (dropDownValue.compareTo(items[0]) == 0) {
                            if (widget.groupBySpendAll != null) {
                              groupBySpend = widget.groupBySpendAll;
                            } else {
                              groupBySpend = [];
                            }
                          }
                          if (dropDownValue.compareTo(items[1]) == 0) {
                            if (widget.groupBySpendDay != null) {
                              groupBySpend = widget.groupBySpendDay;
                            }
                            groupBySpend = [];
                          }
                          if (dropDownValue.compareTo(items[2]) == 0) {
                            if (widget.groupBySpendMoth != null) {
                              groupBySpend = widget.groupBySpendMoth;
                            } else {
                              groupBySpend = [];
                            }
                          }
                          if (dropDownValue.compareTo(items[3]) == 0) {
                            if (widget.groupBySpendYear != null) {
                              groupBySpend = widget.groupBySpendYear;
                            } else {
                              groupBySpend = [];
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 260,
            width: double.infinity,
            child: widget.groupBySpendNull == null || groupBySpend!.length == 0
                ? const Center(
                    child: Text(
                      'Hãy bắt đầu chi tiêu !',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SfCircularChart(
                            legend: Legend(isVisible: true),
                            tooltipBehavior: _tooltipBehavior,
                            series: <CircularSeries<GroupBy, String>>[
                              // Initialize line series
                              PieSeries<GroupBy, String>(
                                dataSource: groupBySpend,
                                xValueMapper: (GroupBy sales, _) =>
                                    sales.name,
                                yValueMapper: (GroupBy sales, _) =>
                                    sales.money,
                                name: 'Số tiền',
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                              )
                            ]),
                      ],
                    ),
                  ),
          ),
          Text(
            'Đơn vị: nghìn',
            style: AppThemes.commonText,
          ),
        ],
      ),
    );
  }
}
