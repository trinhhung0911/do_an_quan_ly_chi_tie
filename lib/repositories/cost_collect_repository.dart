
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/services/cost_collect_service.dart';

class CostCollectRepository{
  Future<dynamic> createCostCollect({required CostCollect costCollect,
  }) async {
    await CostCollectService().createCostCollect(costCollect: costCollect);
  }
  Future<dynamic> getCostCatgoryCollect() async{
    return await CostCollectService().geCostCategoryCollect();
  }


  Future<List<CostCollect>> getCostCollects() async {
    return await CostCollectService().getCostCollects();
  }
  Future<dynamic> deleteCostCollect(
      {required CostCollect costCollect}) async {
    await CostCollectService().deleteCostCollect(costCollect: costCollect);
  }
  Future<dynamic> updateCostCollect(
      {required CostCollect costCollect}) async {
    await CostCollectService().updateCostCollect(costCollect: costCollect);
  }

}