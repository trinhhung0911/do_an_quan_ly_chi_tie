import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/app_data.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/item_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/loai_chi.dart';

class SpendChartCircle extends StatefulWidget {
  const SpendChartCircle({Key? key}) : super(key: key);
  @override
  _SpendChartCircleState createState() => _SpendChartCircleState();
}

class _SpendChartCircleState extends State<SpendChartCircle> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<LoaiChi, String>(
                  dataSource: AppData.danhmucchi,
                  xValueMapper: (LoaiChi data, _) => data.name,
                  yValueMapper: (LoaiChi data, _) => data.money,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  pointColorMapper: (LoaiChi data, _) => data.color)
            ],
          ),
          ItemChart(),
        ],
      ),
    );
  }
}
