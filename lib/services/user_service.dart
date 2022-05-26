import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/models/get_user.dart';
import 'package:quan_ly_chi_tieu/models/group_by_spend.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

class UserService {
  //Create user
  Future<dynamic> createUser({required Users user}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password);
    var userId = userCredential.user!.uid;
    CollectionReference users =
        FirebaseFirestore.instance.collection(CollectionName.users.name);
    user.uid = userId;
    await users.doc(userId).set(user.toJson());
  }

  //GetUser
  Future<List<GetUser>> getUsers() async {
    List<GetUser> getUsers = [];
    var idUser = await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(CollectionName.users.name);
    CollectionReference sumSpendAllCollection =
        FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    CollectionReference sumCollectAllCollection =
        FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
    CollectionReference categorySpendCollectionReference = FirebaseFirestore
        .instance
        .collection(CollectionName.categorySpend.name);

    //thông tin user
    Users? users;
    var data = await usersCollection.get();
    for (var item in data.docs) {
      var e = Users.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.uid == idUser) {
        users = e;
      }
    }
    // tổng tiền thu
    int sumCollectdAll = 0;
    var dataSumCollectAll = await sumCollectAllCollection.get();
    for (var item in dataSumCollectAll.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser) {
        sumCollectdAll = sumCollectdAll + e.money;
      }
    }
    //tổng tất cả tiền thu theo ngày
    int sumDayCollect = 0;
    var dataSumDayCollectAll = await sumCollectAllCollection.get();
    for (var item in dataSumDayCollectAll.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser &&
          e.dateTime!.day.toString() == DateTime.now().day.toString()) {
        sumDayCollect = sumDayCollect + e.money;
      }
    }
    //tổng tất cả tiền thu theo tháng
    int sumMothCollect = 0;
    var dataSumMothCollectAll = await sumCollectAllCollection.get();
    for (var item in dataSumMothCollectAll.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser &&
          e.dateTime!.month.toString() == DateTime.now().month.toString()) {
        sumMothCollect = sumMothCollect + e.money;
      }
    }

    //tổng tất cả tiền thu theo năm
    int sumYearCollect = 0;
    var dataSumYearCollectAll = await sumCollectAllCollection.get();
    for (var item in dataSumYearCollectAll.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser &&
          e.dateTime!.year.toString() == DateTime.now().year.toString()) {
        sumYearCollect = sumYearCollect + e.money;
      }
    }

    //tổng tất cả tiền chi
    int sumSpendAll = 0;
    var dataSumSpendAll = await sumSpendAllCollection.get();
    for (var item in dataSumSpendAll.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser) {
        sumSpendAll = sumSpendAll + e.money;
      }
    }
    //tổng tất cả tiền chi theo ngày
    int sumDaySpend = 0;
    var dataSumDaySpend = await sumSpendAllCollection.get();
    for (var item in dataSumDaySpend.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser &&
          e.dateTime!.day.toString() == DateTime.now().day.toString()) {
        sumDaySpend = sumDaySpend + e.money;
      }
    }
    //tổng tất cả tiền chi theo tháng
    int sumMothSpend = 0;
    var dataSumMothSpend = await sumSpendAllCollection.get();
    for (var item in dataSumMothSpend.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser &&
          e.dateTime!.month.toString() == DateTime.now().month.toString()) {
        sumMothSpend = sumMothSpend + e.money;
      }
    }
    //tổng tất cả tiền thu theo năm
    int sumYearSpend = 0;
    var dataSumYearSpend = await sumSpendAllCollection.get();
    for (var item in dataSumYearSpend.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser &&
          e.dateTime!.year.toString() == DateTime.now().year.toString()) {
        sumYearSpend = sumYearSpend + e.money;
      }
    }

    //GroupBy Spend
    List<GroupBySpend> groupByAllSpend = [];
    List<GroupBySpend> groupByDaySpend = [];
    List<GroupBySpend> groupByMothSpend = [];
    List<GroupBySpend> groupByYearSpend = [];
    var dataGroupSpendCategory = await categorySpendCollectionReference.get();
    var dataGroupSendCost = await sumSpendAllCollection.get();
    //GroupBy All Spend
    int sumMoney = 0;
    bool kt = false;
    for (var categorySpend in dataGroupSpendCategory.docs) {
      var category =
          CategorySpend.fromJson(categorySpend.data() as Map<String, dynamic>)
            ..id = categorySpend.id;
      if (kt == true) {
        bool kt = false;
        sumMoney = 0;
      }
      for (var costSpend in dataGroupSendCost.docs) {
        var spend = CostSpend.formJson(costSpend.data() as Map<String, dynamic>)
          ..id = costSpend.id;
        if (category.idUser == idUser &&
            spend.idUser == idUser &&
            category.id.toString() == spend.idCategorySpend.toString()) {
          sumMoney = sumMoney + spend.money;
          kt = true;
        }
      }
      if (kt == true) {
        if (sumMoney != 0) {
          GroupBySpend groupBySpend =
              GroupBySpend(name: category.name, money: sumMoney);
          groupByAllSpend.add(groupBySpend);
        }
      }
    }

    GetUser value = GetUser(
        user: users,
        sumAllSpend: sumSpendAll,
        sumAllCollect: sumCollectdAll,
        sumDaySpend: sumDaySpend,
        sumMothSpend: sumMothSpend,
        sumYearSpend: sumYearSpend,
        sumDayCollect: sumDayCollect,
        sumMothCollect: sumMothCollect,
        sumYearCollect: sumYearCollect,
        groupBySpendAll: groupByAllSpend);
    getUsers.add(value);
    return getUsers;
  }
}
