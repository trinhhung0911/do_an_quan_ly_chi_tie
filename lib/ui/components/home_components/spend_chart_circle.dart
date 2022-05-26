import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/models/group_by_spend.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpendChartCircle extends StatefulWidget {
  List<GroupBySpend>? groupSpend;
  SpendChartCircle({this.groupSpend});
  @override
  _SpendChartCircleState createState() => _SpendChartCircleState();
}

class _SpendChartCircleState extends State<SpendChartCircle> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SfCircularChart(
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries<GroupBySpend, String>>[
                // Initialize line series
                PieSeries<GroupBySpend, String>(
                  dataSource: widget.groupSpend,
                  xValueMapper: (GroupBySpend sales, _) => sales.name,
                  yValueMapper: (GroupBySpend sales, _) => sales.money,
                  name: 'Số tiền',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ]),
        ],
      ),
    );
  }
}
