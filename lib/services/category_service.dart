import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/categor_spend.dart';
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
  Future<dynamic> updateCategorySpend(
      {required CategorySpend categorySpend}) async {
    print(categorySpend.id);
    CollectionReference categorySpendCollection =
    FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    //var data = await categorySpendCollection.get();
    await categorySpendCollection.doc(categorySpend.id).update(categorySpend.toJson());

  }


}