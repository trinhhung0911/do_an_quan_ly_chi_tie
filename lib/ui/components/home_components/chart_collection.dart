

import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/group_by_spend.dart';
import 'package:quan_ly_chi_tieu/ui/components/home_components/spend_chart_circle.dart';

class ChartCollection extends StatefulWidget {
  List<GroupBySpend>? groupSpend;
  ChartCollection({Key? key, this.groupSpend}) : super(key: key) ;
  @override
  _ChartCollectionState createState() => _ChartCollectionState();
}

class _ChartCollectionState extends State<ChartCollection> {
  static List<String> items = ["Tất cả", "Ngày", "Tháng này", "Năm này"];
  static String dropDownValue = items[0];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
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
           SizedBox(
            height: 260,
            width: double.infinity,
            child: SpendChartCircle(groupSpend: widget.groupSpend,),
          ),
          Text('Đơn vị: nghìn',style: AppThemes.commonText,),
        ],
      ),
    );
  }
}

