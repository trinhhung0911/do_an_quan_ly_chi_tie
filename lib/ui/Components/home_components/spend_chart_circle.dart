import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/app_data.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/item_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/categor_spend.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpendChartCircle extends StatefulWidget {
  const SpendChartCircle({Key? key}) : super(key: key);
  @override
  _SpendChartCircleState createState() => _SpendChartCircleState();
}

class _SpendChartCircleState extends State<SpendChartCircle> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior =  TooltipBehavior(enable: true);
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
              series: <CircularSeries<SalesData, String>>[
                // Initialize line series
                PieSeries<SalesData, String>(
                    dataSource: AppData.danhmucchi,
                    xValueMapper: (SalesData sales, _) => sales.name,
                    yValueMapper: (SalesData sales, _) => sales.money,
                    name: 'Số tiền',
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
        ],
      ),
    );
  }
}
