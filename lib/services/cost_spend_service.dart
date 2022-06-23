import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

class CostSpendService{
//tạo khoản chi
  Future<dynamic> createCostSpend({required CostSpend costSpend,}) async {
    CollectionReference categoryCollection = FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    await categoryCollection.add(costSpend.toJson(),);
    //Trừ vào sumMoney
    var idUser = await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference userCollection = FirebaseFirestore.instance.collection(
        CollectionName.users.name);
    var data = await userCollection.get();
    for (var item in data.docs) {
      var e = Users.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.uid == idUser) {
        await userCollection.doc(e.id).update(
            {'sumMoney': e.sumMoney! - costSpend.money});
      }
    }



  }














  //get danh muc chi
  Future<List<CategorySpend>> getCostCategorySpends() async {
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    List<CategorySpend> categorySpend=[];
    CollectionReference categorySpendCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    var data = await categorySpendCollection.get();
    for (var item in data.docs) {
      var e = CategorySpend.fromJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
        categorySpend.add(e,);
        //print(e.name);
      }
    }
    return categorySpend;
  }

//get tất cả khoản chi
  Future<List<CostSpend>> getCostSpends() async {
    var idUser=await SecureStorage().getString(key: SecureStorage.userId);
    List<CostSpend> costSpend=[];
    CollectionReference categorySpendCollection = FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    var data = await categorySpendCollection.get();
    for (var item in data.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
        costSpend.add(e,);
      }
    }
    return costSpend;
  }

  //xóa khoản chi ?? tiền trong ví
  Future<dynamic> deleteCostSpend({required CostSpend costSpend}) async {
    CollectionReference costSpendCollection = FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    await costSpendCollection.doc(costSpend.id).delete();
    //cộng tiền vào ví
    var idUser = await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference userCollection = FirebaseFirestore.instance.collection(CollectionName.users.name);
    var data = await userCollection.get();
    for (var item in data.docs) {
      var e = Users.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.uid == idUser) {
        await userCollection.doc(e.id).update(
            {'sumMoney': e.sumMoney! + costSpend.money});
      }
    }

  }

  //cập nhật khoản chi ?? tiền trong ví
  Future<dynamic> updateCostSpend({required CostSpend costSpend}) async {
    //Lấy ra tiền cũ
    int money=0;//tiền chi cũ
    //id User
    var idUser = await SecureStorage().getString(key: SecureStorage.userId);
    //bảng user
    CollectionReference userCollection = FirebaseFirestore.instance.collection(CollectionName.users.name);
    // bảng khoản chi
    CollectionReference costSpendCollection = FirebaseFirestore.instance.collection(CollectionName.costSpend.name);

    var data = await costSpendCollection.get();
    for (var item in data.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser== idUser&&e.id==costSpend.id) {
           money=e.money;
      }
    }

    //Cập nhật trong bảng User
    var dataUser = await userCollection.get();
    for (var item in dataUser.docs) {
      var e = Users.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.uid == idUser) {
        await userCollection.doc(e.id).update(
            {'sumMoney': e.sumMoney! +(money-costSpend.money)});
        print('Tổng tiền');
        print(e.sumMoney!);
      }
    }
    await costSpendCollection.doc(costSpend.id).update(costSpend.toJson());
  }

}