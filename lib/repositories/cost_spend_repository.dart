import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/services/cost_spend_service.dart';

class CostSpendRepository{
  Future<dynamic> createCostSpend({required CostSpend costSpend,}) async {
    await CostSpendService().createCostSpend(costSpend: costSpend);
  }
  Future<List<CategorySpend>> getCostCategorySpends() async {
    return await CostSpendService().getCostCategorySpends();
  }
  Future<List<CostSpend>> getCostSpends() async {
    return await CostSpendService().getCostSpends();
  }
  Future<dynamic> deleteCostSpend(
      {required CostSpend costSpend}) async {
    await CostSpendService().deleteCostSpend(costSpend: costSpend);
  }
  Future<dynamic> updateCostSpend(
      {required CostSpend costSpend}) async {
    await CostSpendService().updateCostSpend(costSpend: costSpend);
  }

}