import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/get_user.dart';

class StatusCollection extends StatefulWidget {
  GetUser getUser;
  StatusCollection({Key? key, required this.getUser}) : super(key: key);
  @override
  _StatusCollectionState createState() => _StatusCollectionState();
}

class _StatusCollectionState extends State<StatusCollection> {
  static List<String> items = ["Tất cả", "Ngày này", "Tháng này", "Năm nay"];
  late String dropDownValue;
  late int sumSpend;
  late int sumCollect;
  @override
  void initState() {
    dropDownValue = items[0];
    sumSpend = widget.getUser.sumAllSpend ?? 0;
    sumCollect = widget.getUser.sumAllCollect ?? 0;
    // TODO: implement initState
    super.initState();
  }

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(
            'Tình hình thu chi',
            style: AppThemes.commonText,
          ),
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
                        sumSpend = widget.getUser.sumAllSpend ?? 0;
                        sumCollect = widget.getUser.sumAllCollect ?? 0;
                      }
                      if (dropDownValue.compareTo(items[1]) == 0) {
                        sumSpend = widget.getUser.sumDaySpend ?? 0;
                        sumCollect = widget.getUser.sumDayCollect ?? 0;
                      }
                      if (dropDownValue.compareTo(items[2]) == 0) {
                        sumSpend = widget.getUser.sumMothSpend ?? 0;
                        sumCollect = widget.getUser.sumMothCollect ?? 0;
                      }
                      if (dropDownValue.compareTo(items[3]) == 0) {
                        sumSpend = widget.getUser.sumYearSpend ?? 0;
                        sumCollect = widget.getUser.sumYearCollect ?? 0;
                      }
                    },
                  );
                },
              ),
            ),
          ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: sumSpend!=0? sumSpend*100/(sumSpend+sumCollect):100,
                      width: 40,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      height:sumCollect!=0? sumCollect*100/(sumSpend+sumCollect):100,
                      width: 40,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 40),
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
                            const SizedBox(width: 20,),
                            Text(
                              sumCollect.toString(),
                              style: AppThemes.commonText
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 45,
                        ),
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
                            const SizedBox(width: 20,),
                            Text(
                              sumSpend.toString(),
                              style: AppThemes.commonText
                                  .copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),

    );
  }
}
