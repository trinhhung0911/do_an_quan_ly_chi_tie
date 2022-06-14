import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_Collect.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/models/get_user.dart';
import 'package:quan_ly_chi_tieu/models/group_by.dart';
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
    // tổng tiền thu all
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
      if (e.idUser == idUser && e.dateTime!.month.toString() == DateTime.now().month.toString()) {
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
    List<GroupBy> groupByAllSpend = [];
    List<GroupBy> groupByDaySpend = [];
    List<GroupBy> groupByMothSpend = [];
    List<GroupBy> groupByYearSpend = [];
    List<GroupBy> groupByNullSpend = [];
    List<CategoryCollect> categoryCollects=[];
    List<CategorySpend> categorySpends = [];
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
          GroupBy groupBySpend = GroupBy(name: category.name, money: sumMoney);
               groupByAllSpend.add(groupBySpend);
        }
      }
    }

    //Group By Day Spend
    int sumDayMoney = 0;
    bool ktDay = false;
    for (var categorySpend in dataGroupSpendCategory.docs) {
      var category = CategorySpend.fromJson(categorySpend.data() as Map<String, dynamic>)..id = categorySpend.id;
      if (ktDay == true) {
        bool ktDay = false;sumDayMoney = 0;
      }
      for (var costSpend in dataGroupSendCost.docs) {
        var spend = CostSpend.formJson(costSpend.data() as Map<String, dynamic>)
          ..id = costSpend.id;
        if (category.idUser == idUser && spend.idUser == idUser &&
            category.id.toString() == spend.idCategorySpend.toString()&&
            spend.dateTime!.day.toString()==DateTime.now().day.toString()
        ) {
          sumDayMoney = sumDayMoney + spend.money;
          ktDay = true;
        }
      }
      if (ktDay == true) {
        if (sumDayMoney != 0) {
          GroupBy groupBySpend = GroupBy(name: category.name, money: sumDayMoney);
          groupByDaySpend.add(groupBySpend);
        }
      }
    }


    //Group By Moth Spend
    int sumMothMoney = 0;
    bool ktMoth = false;
    for (var categorySpend in dataGroupSpendCategory.docs) {
      var category =
      CategorySpend.fromJson(categorySpend.data() as Map<String, dynamic>)
        ..id = categorySpend.id;
      if (ktMoth == true) {
        bool ktMoth = false;
        sumMothMoney = 0;
      }
      for (var costSpend in dataGroupSendCost.docs) {
        var spend = CostSpend.formJson(costSpend.data() as Map<String, dynamic>)
          ..id = costSpend.id;
        if (category.idUser == idUser && spend.idUser == idUser &&
            category.id.toString() == spend.idCategorySpend.toString()&&
            spend.dateTime!.month.toString()==DateTime.now().month.toString()
        ) {
          sumMothMoney = sumMothMoney + spend.money;
          ktMoth = true;
        }
      }
      if (ktMoth == true) {
        if (sumMothMoney != 0) {
          GroupBy groupBySpend = GroupBy(name: category.name, money: sumMothMoney);
          groupByMothSpend.add(groupBySpend);
        }
      }
    }
    //Group By Year Spend
    int sumYearMoney = 0;
    bool ktYear = false;
    for (var categorySpend in dataGroupSpendCategory.docs) {
      var category =
      CategorySpend.fromJson(categorySpend.data() as Map<String, dynamic>)..id = categorySpend.id;
      if (ktYear == true) {
        bool ktYear = false;
        sumYearMoney = 0;
      }
      for (var costSpend in dataGroupSendCost.docs) {
        var spend = CostSpend.formJson(costSpend.data() as Map<String, dynamic>)
          ..id = costSpend.id;
        if (category.idUser == idUser && spend.idUser == idUser &&
            category.id.toString() == spend.idCategorySpend.toString()&&
            spend.dateTime!.year.toString()==DateTime.now().year.toString()
        ) {
          sumYearMoney = sumYearMoney + spend.money;
          ktYear = true;
        }
      }
      if (ktYear == true) {
        if (sumYearMoney != 0) {
          GroupBy groupBySpend = GroupBy(name: category.name, money: sumYearMoney);
          groupByYearSpend.add(groupBySpend);
        }
      }
    }
    //Group By Null
    for (var categorySpend in dataGroupSpendCategory.docs) {
      var category = CategorySpend.fromJson(categorySpend.data() as Map<String, dynamic>)..id = categorySpend.id;
        if (category.idUser == idUser) {
          GroupBy groupBySpend = GroupBy(name: category.name, money: 0);
          groupByNullSpend.add(groupBySpend);
        }
      }
    //get Category Collect


    CollectionReference categoryCollectCollection = FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);
    var dataCategory = await categoryCollectCollection.get();
    for (var item in dataCategory.docs) {
      var e = CategoryCollect.fromJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
        categoryCollects.add(e);
      }
    }
    //Get Category Spend
    CollectionReference categorySpendCollection = FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    var dataCategorySpend = await categorySpendCollection.get();
    for (var item in dataCategorySpend.docs) {
      var e = CategorySpend.fromJson(item.data() as Map<String, dynamic>)..id = item.id;
      if(e.idUser == idUser) {
        categorySpends.add(e,);
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
        groupBySpendAll: groupByAllSpend,
        groupBySpendDay: groupByDaySpend,
        groupBySpendMoth: groupByMothSpend,
        groupBySpendYear: groupByYearSpend,
        groupBySpendNull: groupByNullSpend,
      categoryCollects: categoryCollects,
      categorySpends: categorySpends
    );
    getUsers.add(value);
    return getUsers;
  }
}
