import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/ui/manage_collect/manage_collect/manage_collect_screenn.dart';
import '../../../bloc/cost_collect_bloc/cost_collect_bloc.dart';
import '../../../bloc/cost_collect_bloc/cost_collect_event.dart';


class InputSearchCollect extends StatefulWidget {
  @override
  _InputSearchCollectState createState() => _InputSearchCollectState();
  final Function(String)? onChanged;
  const InputSearchCollect(this.onChanged);
  static TextEditingController textSearchController = TextEditingController();
  static List<String> items = [
    'Tất cả',
    'Ngày này',
    'Tháng này',
    'Năm này',
  ];
  static String dropDownValue = items[0];
}

class _InputSearchCollectState extends State<InputSearchCollect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appColor,
      padding: const EdgeInsets.only(top: 15, bottom: 15,left: 16,right: 16),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              height: 56,
              decoration: const BoxDecoration(
                color:  Color(0xFFF5F2F2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: widget.onChanged,
                  controller: InputSearchCollect.textSearchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    alignLabelWithHint: false,
                    hintText: 'Tìm kiếm',
                    border: InputBorder.none,
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    suffixIcon: IconButton(
                      constraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                      padding: const EdgeInsets.only(bottom: 0, right: 10),
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: InputSearchCollect.textSearchController.text
                            .trim()
                            .isNotEmpty
                            ? Colors.blue
                            : Colors.black,
                      ),
                      // icon: Icon(Icons.date_range_outlined),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            padding: const EdgeInsets.only(
              left: 10,
            ),
            height: 56,
            decoration: const BoxDecoration(
              color:  Color(0xFFF5F2F2),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: InputSearchCollect.dropDownValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: InputSearchCollect.items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                        () {
                      InputSearchCollect.dropDownValue = newValue!;
                      if (InputSearchCollect.dropDownValue.compareTo(InputSearchCollect.items[0]) == 0) {
                        ManageCollectScreen.indext = 0;
                        ManageCollectScreen.isFetch = false;
                        InputSearchCollect.textSearchController.clear();
                      }
                      if (InputSearchCollect.dropDownValue.compareTo(InputSearchCollect.items[1]) == 0) {
                        ManageCollectScreen.indext = 1;
                        ManageCollectScreen.isFetch = false;
                        InputSearchCollect.textSearchController.clear();

                      }
                      if (InputSearchCollect.dropDownValue.compareTo(InputSearchCollect.items[2]) == 0) {

                        ManageCollectScreen.indext = 2;
                        ManageCollectScreen.isFetch = false;
                        InputSearchCollect.textSearchController.clear();
                      }
                      if (InputSearchCollect.dropDownValue.compareTo(InputSearchCollect.items[3]) == 0) {
                        ManageCollectScreen.indext = 3;
                        ManageCollectScreen.isFetch = false;
                        InputSearchCollect.textSearchController.clear();
                      }
                    },
                  );
                  BlocProvider.of<CostCollectBloc>(context).add(GetCostCollectsEvent());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
