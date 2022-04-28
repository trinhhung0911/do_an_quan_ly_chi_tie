

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

import '../models/category_Collect.dart';

class CategoryCollectService{

  Future<dynamic> createCategoryCollect({required CategoryCollect categoryCollect,}) async {
    CollectionReference categoryCollection = FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    categoryCollect.idUser=idUser;
    await categoryCollection.add(categoryCollect.toJson());
  }

  Future<List<CategoryCollect>> getCategoryCollects() async {
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    List<CategoryCollect> categoryCollect=[];
    CollectionReference categoryCollectCollection = FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    var data = await categoryCollectCollection.get();
    for (var item in data.docs) {
      var e = CategoryCollect.fromJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
        categoryCollect.add(e,);
        print(e.name);
        print(e.note);
      }
    }
    return categoryCollect;

  }

  Future<dynamic> updateCategoryCollect({required CategoryCollect categoryCollect}) async {
    CollectionReference categoryCollectCollection =
    FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    await categoryCollectCollection.doc(categoryCollect.id).update(categoryCollect.toJson());
  }
  Future<dynamic> deleteCategoryCollect({required CategoryCollect categoryCollect}) async {
    CollectionReference categoryCollectCollection = FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    await categoryCollectCollection.doc(categoryCollect.id).delete();
  }


}