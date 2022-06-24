import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';

class StatisticalOption{
  final List<CostSpend> costSpend;
  final List<CostCollect> costCollect;
  StatisticalOption({required this.costCollect, required this.costSpend});
}