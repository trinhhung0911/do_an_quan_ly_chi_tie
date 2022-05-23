

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';


class CostCollectService{
  //tạo khoản thu
  Future<dynamic> createCostCollect({required CostCollect costCollect,}) async {
    CollectionReference categoryCollection = FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
 await categoryCollection.add(costCollect.toJson());
  }
  //get tất cả danh mục thu
  Future<List<CategoryCollect>> geCostCategoryCollect() async{
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    List<CategoryCollect> categoryCollect=[];
    CollectionReference categoryCollectCollection = FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    var data = await categoryCollectCollection.get();
    for (var item in data.docs) {
      var e = CategoryCollect.fromJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
        categoryCollect.add(e,);
      }
    }
    return categoryCollect;
  }
//get tất cả nguồn thu
  Future<List<CostCollect>> getCostCollects() async {
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    List<CostCollect> costCollect=[];
    CollectionReference categoryCollectCollection = FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
    var data = await categoryCollectCollection.get();
    for (var item in data.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
        costCollect.add(e,);
      }
    }
    return costCollect;
  }
  //xóa nguồn thu
  Future<dynamic> deleteCostCollect({required CostCollect costCollect}) async {
    CollectionReference categoryCollectCollection = FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
    await categoryCollectCollection.doc(costCollect.id).delete();
  }
  //cập nhật nguồn thu
  Future<dynamic> updateCostCollect({required CostCollect costCollect}) async {
    CollectionReference costCollectCollection =
    FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
    await costCollectCollection.doc(costCollect.id).update(costCollect.toJson());
  }


}