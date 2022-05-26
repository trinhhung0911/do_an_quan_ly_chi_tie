

class AppData {
static List<SalesData> danhmucchi=[
  SalesData('Quần áo', 350000),
  SalesData('Giày dép', 280000),
  SalesData('Du lịch', 34000),
  SalesData('Điện nước', 32000),
  SalesData('Sức khỏe', 40000),
];

}
class SalesData {
  SalesData(this.name, this.money);
  final String name;
  final double money;
}