import 'package:quan_ly_chi_tieu/models/group_by.dart';


class GetStatistical{

  int? sumDaySpend;
  int? sumMothSpend;
  int? sumYearSpend;

  int? sumDayCollect;
  int? sumMothCollect;
  int? sumYearCollect;

  List<GroupBy>? groupBySpendDay;
  List<GroupBy>? groupByCollectDay;
  List<GroupBy>? groupBySpendMoth;
  List<GroupBy>? groupByCollectMoth;
  List<GroupBy>? groupBySpendYear;
  List<GroupBy>? groupByCollectYear;

  GetStatistical(
  {this.sumDaySpend,
      this.sumMothSpend,
      this.sumYearSpend,
      this.sumDayCollect,
      this.sumMothCollect,
      this.sumYearCollect,
      this.groupBySpendDay,
      this.groupByCollectDay,
      this.groupBySpendMoth,
      this.groupByCollectMoth,
      this.groupBySpendYear,
      this.groupByCollectYear});
}
