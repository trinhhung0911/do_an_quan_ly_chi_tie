import 'package:quan_ly_chi_tieu/models/category_Collect.dart';
import 'package:quan_ly_chi_tieu/services/category_collect_service.dart';

class CategoryCollectRepository{
  Future<dynamic> createCategoryCollect({required CategoryCollect categoryCollect,
  }) async {
    await CategoryCollectService().createCategoryCollect(categoryCollect: categoryCollect);
  }
  Future<List<CategoryCollect>> getCategoryCollects() async {
    return await CategoryCollectService().getCategoryCollects();
  }
  Future<dynamic> updateCategoryCollect(
      {required CategoryCollect categoryCollect}) async {
    await CategoryCollectService().updateCategoryCollect(categoryCollect: categoryCollect);
  }
  Future<dynamic> deleteCategoryCollect(
      {required CategoryCollect categoryCollect}) async {
    await CategoryCollectService().deleteCategoryCollect(categoryCollect: categoryCollect);
  }

}