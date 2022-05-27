import 'package:quan_ly_chi_tieu/models/group_by_spend.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';

class GetUser {
  Users? user;
  int? sumAllCollect;
  int? sumAllSpend;

  int? sumDaySpend;
  int? sumMothSpend;
  int? sumYearSpend;

  int? sumDayCollect;
  int? sumMothCollect;
  int? sumYearCollect;

  List<GroupBySpend>? groupBySpendAll;
  List<GroupBySpend>? groupBySpendDay;
  List<GroupBySpend>? groupBySpendMoth;
  List<GroupBySpend>? groupBySpendYear;
  List<GroupBySpend>? groupBySpendNull;

  GetUser(
      {this.user,
      this.sumAllCollect,
      this.sumAllSpend,
      this.sumDaySpend,
      this.sumMothSpend,
      this.sumYearSpend,
      this.sumDayCollect,
      this.sumMothCollect,
      this.sumYearCollect,
      this.groupBySpendAll,
      this.groupBySpendDay,
      this.groupBySpendMoth,
      this.groupBySpendYear,
      this.groupBySpendNull});
}
