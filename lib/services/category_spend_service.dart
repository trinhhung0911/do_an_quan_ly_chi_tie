

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

class CategorySpendService{
  //Tạo danh mục chi
   Future<dynamic> createCategorySpend({required CategorySpend categorySpend,}) async {
    bool kt=true;
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference categoryCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    var nameCategorySpend = await categoryCollection.get();
    for (var category in nameCategorySpend.docs) {
      var categoryName = CategorySpend.fromJson(category.data() as Map<String, dynamic>)..id = category.id;
      if(categoryName.name==categorySpend.name&&categoryName.idUser == idUser){
        kt==false;
      }
    }
    categorySpend.idUser=idUser;
    await categoryCollection.add(categorySpend.toJson());


  }

//get tất cả danh mục chi
  Future<List<CategorySpend>> getCategorySpends() async {
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    List<CategorySpend> categorySpend=[];
    CollectionReference categorySpendCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    var data = await categorySpendCollection.get();
    for (var item in data.docs) {
      var e = CategorySpend.fromJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
        categorySpend.add(e,);
      }
    }
    return categorySpend;
  }

//Cập nhật danh mục chi
  Future<dynamic> updateCategorySpend({required CategorySpend categorySpend}) async {
    //Cập nhật danh mục chi
    CollectionReference categorySpendCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    await categorySpendCollection.doc(categorySpend.id).update(categorySpend.toJson());

   //Cập nhật khoản chi
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference costSpendCollection = FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    var data = await costSpendCollection.get();
    for (var item in data.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser && e.idCategorySpend==categorySpend.id) {
        await costSpendCollection.doc(e.id).update({'nameCategorySpend' :categorySpend.name  });
      }
    }
  }

    //Xóa danh mục chi
  Future<dynamic> deleteCategorySpend({required CategorySpend categorySpend}) async {
    //Xóa danh mục chi
    CollectionReference categorySpendCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    await categorySpendCollection.doc(categorySpend.id).delete();
    //Cập nhật khoản chi
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference costSpendCollection = FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    var data = await costSpendCollection.get();
    for (var item in data.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser && e.idCategorySpend==categorySpend.id) {
        await costSpendCollection.doc(e.id).update({'nameCategorySpend' :"Null",'idCategorySpend':'Null'});
      }
    }
  }


}