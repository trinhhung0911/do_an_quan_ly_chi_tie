import 'package:quan_ly_chi_tieu/models/category_spend.dart';

class AppData {
static List<SalesData> danhmucchi=[
  SalesData('Quần áo', 350000),
  SalesData('Giày dép', 280000),
  SalesData('Du lịch', 34000),
  SalesData('Điện nước', 32000),
  SalesData('Sức khỏe', 40000),
];
static List<CategorySpend> listLoaiChi=[
  CategorySpend(id: '1',name: 'Gia đình' ,note: 'Chi tiêu cho gia đình'),
  CategorySpend(id: '2',name: 'Sức khỏe' ,note: 'Chi tiêu cho sức khỏe'),
];
}
class SalesData {
  SalesData(this.name, this.money);
  final String name;
  final double money;
}