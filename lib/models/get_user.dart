import 'package:quan_ly_chi_tieu/models/group_by.dart';
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

  List<GroupBy>? groupBySpendAll;
  List<GroupBy>? groupBySpendDay;
  List<GroupBy>? groupBySpendMoth;
  List<GroupBy>? groupBySpendYear;
  List<GroupBy>? groupBySpendNull;

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
