import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';

class StatusCollection extends StatefulWidget {
  const StatusCollection({Key? key}) : super(key: key);
  @override
  _StatusCollectionState createState() => _StatusCollectionState();
}

class _StatusCollectionState extends State<StatusCollection> {
  static List<String> items = [
  "Tất cả" ,"Tháng này", "Tuần này", "Năm nay"
  ];
  static String dropDownValue = items[0];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 15.0),
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 42,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(
                      'Tình hình thu chi',
                      style: AppThemes.commonText,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 130,
                            width: 40,
                            color: Colors.red,
                          ),
                          Container(
                            height: 20,
                            width: 40,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
           flex: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
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
                Padding(
                  padding: const EdgeInsets.only(left: 50,top: 40),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 7.0,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('Thu', style: AppThemes.commonText),
                            ],
                          ),
                          Text(
                            '2.000.000',
                            style: AppThemes.commonText.copyWith(color: Colors.green),),
                        ],
                      ),
                      const SizedBox(height: 45,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 7.0,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('Chi', style: AppThemes.commonText),
                            ],
                          ),
                          Text(
                            '1.234.567',
                            style: AppThemes.commonText.copyWith(color: Colors.red),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
