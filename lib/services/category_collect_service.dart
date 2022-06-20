

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

import '../models/category_Collect.dart';

class CategoryCollectService{
  //tạo danh mục thu
  Future<dynamic> createCategoryCollect({required CategoryCollect categoryCollect,}) async {


    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference categoryCollection = FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    var nameCategoryCollect = await categoryCollection.get();
    for (var category in nameCategoryCollect.docs) {
      var categoryName = CategoryCollect.fromJson(category.data() as Map<String, dynamic>)..id = category.id;
      if(categoryName.name==categoryCollect.name&&categoryName.idUser == idUser){
        print('Trùng111');
       // throw Exception("Bạn đã xin nghỉ ở buổi này !");
      }
    }
    categoryCollect.idUser=idUser;
    await categoryCollection.add(categoryCollect.toJson());
  }


 //get danh muc thu
  Future<List<CategoryCollect>> getCategoryCollects() async {
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
//Cập nhật danh mục thu
  Future<dynamic> updateCategoryCollect({required CategoryCollect categoryCollect}) async {
    //Cập nhật danh mục thu
    CollectionReference categoryCollectCollection =
    FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    await categoryCollectCollection.doc(categoryCollect.id).update(categoryCollect.toJson(),);
    //Cập nhật khoản thu
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference costCollectCollection = FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
    var data = await costCollectCollection.get();
    for (var item in data.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser && e.idCategoryCollect==categoryCollect.id) {
        await costCollectCollection.doc(e.id).update({'nameCategoryCollect' :categoryCollect.name});
      }
    }
  }
  //Xóa khoản thu
  Future<dynamic> deleteCategoryCollect({required CategoryCollect categoryCollect}) async {
    CollectionReference categoryCollectCollection = FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    await categoryCollectCollection.doc(categoryCollect.id).delete();

    //Cập nhật khoản thu
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference costCollectCollection = FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
    var data = await costCollectCollection.get();
    for (var item in data.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser && e.idCategoryCollect==categoryCollect.id) {
        await costCollectCollection.doc(e.id).update({'nameCategoryCollect' :"Null",'idCategorySpend':'Null'});
      }
    }
  }


}