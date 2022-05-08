

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

class CategorySpendService{
  Future<dynamic> createCategorySpend({required CategorySpend categorySpend,}) async {
    CollectionReference categoryCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    categorySpend.idUser=idUser;
   await categoryCollection.add(categorySpend.toJson());
  }

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

  Future<dynamic> updateCategorySpend({required CategorySpend categorySpend}) async {
    //update category spend
    CollectionReference categorySpendCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    await categorySpendCollection.doc(categorySpend.id).update(categorySpend.toJson());

   //update cost spend
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

  Future<dynamic> deleteCategorySpend({required CategorySpend categorySpend}) async {
    //delete Category Spend
    CollectionReference categorySpendCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    await categorySpendCollection.doc(categorySpend.id).delete();
    //update cost Spend
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