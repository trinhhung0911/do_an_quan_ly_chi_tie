import 'package:quan_ly_chi_tieu/models/users.dart';

class GetUser{
  Users? user;
  int? sumAllCollect;
  int? sumAllSpend;
  int? sumDaySpend;
  int? sumMothSpend;
  int? sumYearSpend;
  GetUser({ this.user, this.sumAllCollect, this.sumAllSpend, this.sumDaySpend, this.sumMothSpend, this.sumYearSpend});
}