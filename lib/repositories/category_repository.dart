import 'package:quan_ly_chi_tieu/models/categor_spend.dart';
import 'package:quan_ly_chi_tieu/services/category_service.dart';

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

}