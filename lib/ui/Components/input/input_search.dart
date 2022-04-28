import 'package:flutter/material.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';

class InputSearch extends StatefulWidget {
  _InputSearchState createState() => _InputSearchState();
  final Function(String)? onChanged;
  const InputSearch(this.onChanged);
  static TextEditingController textSearchController = TextEditingController();
  static List<String> items = [
    'Tất cả',
    'Tuần này',
    'Tháng này',
    'Năm này',
  ];
  static String dropDownValue = items[0];
}

class _InputSearchState extends State<InputSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 28, right: 24),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.boxColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: TextFormField(
                  onChanged: widget.onChanged,
                  controller: InputSearch.textSearchController,
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
                      padding: EdgeInsets.only(bottom: 0, right: 10),
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: InputSearch.textSearchController.text
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
              color: AppColors.boxColor,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: InputSearch.dropDownValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: InputSearch.items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      InputSearch.dropDownValue = newValue!;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
