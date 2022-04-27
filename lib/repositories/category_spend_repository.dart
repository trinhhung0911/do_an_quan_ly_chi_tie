import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/services/category_spend_service.dart';

class CategorySpendRepository{
  Future<dynamic> createCategorySpend({required CategorySpend categorySpend,
  }) async {
    await CategorySpendService().createCategorySpend(categorySpend: categorySpend);
  }
  Future<List<CategorySpend>> getCategorySpends() async {
    return await CategorySpendService().getCategorySpends();
  }
  Future<dynamic> updateCategorySpend(
      {required CategorySpend categorySpend}) async {
    await CategorySpendService().updateCategorySpend(categorySpend: categorySpend);
  }
  Future<dynamic> deleteCategorySpend(
      {required CategorySpend categorySpend}) async {
    await CategorySpendService().deleteCategorySpend(categorySpend: categorySpend);
  }

}