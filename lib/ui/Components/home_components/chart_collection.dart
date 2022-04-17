import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/app_data.dart';
import 'package:quan_ly_chi_tieu/models/loai_chi.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/spend_chart_circle.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../configs/themes.dart';
class ChartCollection extends StatefulWidget {
  const ChartCollection({Key? key}) : super(key: key);
  @override
  _ChartCollectionState createState() => _ChartCollectionState();
}

class _ChartCollectionState extends State<ChartCollection> {
  static List<String> items = [
    "Hôm nay", "Tuần này", "Tháng này", "Năm nay"
  ];
  static String dropDownValue = items[2];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10,right: 24,left: 24),
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
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 260,
            width: double.infinity,
            child: SpendChartCircle(),
          ),
          Text('Đơn vị: nghìn',style: AppThemes.commonText,),
        ],
      ),
    );
  }
}

