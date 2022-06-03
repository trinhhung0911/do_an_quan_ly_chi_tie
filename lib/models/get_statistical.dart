import 'package:quan_ly_chi_tieu/models/group_by.dart';

class GetStatistical{

   List<GroupBy>? groupSumSpendCollectDay;
   List<GroupBy>? groupSumSpendCollectMoth;
   List<GroupBy>? groupSumSpendCollectYear;
  //tổng chi theo ngày
  List<GroupBy>? groupBySpendDay;
  //thổng thu theo ngày
  List<GroupBy>? groupByCollectDay;
  //tổng chi theo tháng
  List<GroupBy>? groupBySpendMoth;
  //tổng thu theo tháng
  List<GroupBy>? groupByCollectMoth;
  //tổng chi theo năm
  List<GroupBy>? groupBySpendYear;
  //tổng thu theo năm
  List<GroupBy>? groupByCollectYear;

  GetStatistical(
     {this.groupSumSpendCollectDay,
      this.groupSumSpendCollectMoth,
      this.groupSumSpendCollectYear,
      this.groupBySpendDay,
      this.groupByCollectDay,
      this.groupBySpendMoth,
      this.groupByCollectMoth,
      this.groupBySpendYear,
      this.groupByCollectYear});
}
