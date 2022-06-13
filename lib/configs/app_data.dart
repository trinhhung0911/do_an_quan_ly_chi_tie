

import 'package:quan_ly_chi_tieu/models/group_by.dart';

class AppData {
static List<GroupBy> sumCollectSpend=[
  GroupBy(name: 'Tổng chi',money: 0),
  GroupBy(name: 'Tổng thu',money: 0),
];

static List<GroupBy> groupSpend=[
  GroupBy(name: 'Quần áo',money: 1101),
  GroupBy(name: 'Sức khỏe',money: 115),
  GroupBy(name: 'Quần áo',money: 1101),
  GroupBy(name: 'Sức khỏe',money: 115),
  GroupBy(name: 'Quần áo',money: 1101),
  GroupBy(name: 'Sức khỏe',money: 115),
];

static List<GroupBy> groupCollect=[
  GroupBy(name: 'Quần áo',money: 1101),
  GroupBy(name: 'Sức khỏe',money: 115),
  GroupBy(name: 'Di chuyển',money: 111),
];

}
