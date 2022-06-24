import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_collect.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/models/get_statistical.dart';
import 'package:quan_ly_chi_tieu/models/group_by.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

class StatisticalServices{
  Future<GetStatistical> getStatistical() async {
    var idUser = await SecureStorage().getString(key: SecureStorage.userId);
    CollectionReference usersCollection = FirebaseFirestore.instance.collection(CollectionName.users.name);
    CollectionReference costSpendCollection= FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    CollectionReference costCollectCollection = FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
    CollectionReference categorySpendCollection= FirebaseFirestore.instance.collection(CollectionName.categorySpend.name);
    CollectionReference categoryCollectCollection= FirebaseFirestore.instance.collection(CollectionName.categoryCollect.name);

    //Tổng chi theo ngày,tháng,năm hôm qua
    //Tổng tất cả tiền chi theo ngày hôm qua
    int sumDaySpendLast= 0;
    var dataSumDaySpendAllLats = await costSpendCollection.get();
    for (var item in dataSumDaySpendAllLats.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.day.toString() == (DateTime.now().day-1).toString()) {
        sumDaySpendLast = sumDaySpendLast + e.money;
      }
    }
    int sumMothSpendLast= 0;
    var dataSumMothSpendAllLats = await costSpendCollection.get();
    for (var item in dataSumMothSpendAllLats.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.month.toString() == (DateTime.now().month-1).toString()) {
        sumMothSpendLast = sumMothSpendLast + e.money;
      }
    }
    int sumYearSpendLast= 0;
    var dataSumYearSpendAllLats = await costSpendCollection.get();
    for (var item in dataSumYearSpendAllLats.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.year.toString() == (DateTime.now().year-1).toString()) {
        sumYearSpendLast = sumYearSpendLast + e.money;
      }
    }
    //Tổng chi ngày hôm nay.





    //Tổng thu chi theo ngày
    //tổng tất cả tiền thu theo ngày
    int sumDayCollect = 0;
    var dataSumDayCollectAll = await costCollectCollection.get();
    for (var item in dataSumDayCollectAll.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.day.toString() == DateTime.now().day.toString()) {
        sumDayCollect = sumDayCollect + e.money;
      }
    }
    //Tổng tất cả tiền chi theo ngày
    int sumDaySpend = 0;
    var dataSumDaySpendAll = await costSpendCollection.get();
    for (var item in dataSumDaySpendAll.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.day.toString() == DateTime.now().day.toString()) {
        sumDaySpend = sumDaySpend + e.money;
      }
    }
    List<GroupBy> groupSumSpendCollectDay=[];
    GroupBy   groupSumCollectDay= GroupBy(name: 'Tổng thu ',money: sumDayCollect);
    GroupBy   groupSumSpendDay= GroupBy(name: 'Tổng chi ',money: sumDaySpend);
    groupSumSpendCollectDay.add(groupSumSpendDay);
    groupSumSpendCollectDay.add(groupSumCollectDay);




    //tổng tất cả tiền thu theo tháng
    int sumMonthCollect = 0;
    var dataSumMothCollectAll = await costCollectCollection.get();
    for (var item in dataSumMothCollectAll.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.month.toString() == DateTime.now().month.toString()) {
        sumMonthCollect = sumMonthCollect + e.money;
      }
    }
    //Tổng tất cả tiền chi theo tháng
    int sumMothSpend = 0;
    var dataSumMothSpendAll = await costSpendCollection.get();
    for (var item in dataSumMothSpendAll.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.month.toString() == DateTime.now().month.toString()) {
        sumMothSpend = sumMothSpend + e.money;
      }
    }
    List<GroupBy> groupSumSpendCollectMoth=[];
    GroupBy   groupSumCollectMoth= GroupBy(name: 'Tổng thu ',money: sumMonthCollect);
    GroupBy   groupSumSpendMoth=GroupBy(name: 'Tổng chi ',money: sumMothSpend);
    groupSumSpendCollectMoth.add(groupSumCollectMoth);
    groupSumSpendCollectMoth.add(groupSumSpendMoth);

    //tổng tất cả tiền thu theo năm
    int sumYearCollect = 0;
    var dataSumYearCollectAll = await costCollectCollection.get();
    for (var item in dataSumYearCollectAll.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.year.toString() == DateTime.now().year.toString()) {
        sumYearCollect = sumYearCollect + e.money;
      }
    }
    //Tổng tất cả tiền chi theo năm
    int sumYearSpend = 0;
    var dataSumYearSpendAll = await costSpendCollection.get();
    for (var item in dataSumYearSpendAll.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)..id = item.id;
      if (e.idUser == idUser && e.dateTime!.year.toString() == DateTime.now().year.toString()) {
        sumYearSpend = sumYearSpend + e.money;
      }
    }
    List<GroupBy> groupSumSpendCollectYear=[];
    GroupBy   groupSumCollectYear= GroupBy(name: 'Tổng thu ',money: sumYearCollect);
    GroupBy   groupSumSpendYear= GroupBy(name: 'Tổng chi ',money: sumYearSpend);
    groupSumSpendCollectYear.add(groupSumCollectYear);
    groupSumSpendCollectYear.add(groupSumSpendYear);

    //group by
    List<GroupBy> groupByDaySpend = [];
    List<GroupBy> groupByMothSpend = [];
    List<GroupBy> groupByYearSpend = [];
    List<GroupBy> groupByDayCollect = [];
    List<GroupBy> groupByMothCollect = [];
    List<GroupBy> groupByYearCollect = [];
    var dataGroupSpendCategory = await categorySpendCollection.get();
    var dataGroupSendCost = await costSpendCollection.get();
    var dataGroupCollectCategory = await categoryCollectCollection.get();
    var dataGroupCollectCost = await costCollectCollection.get();

    //Group by tiền chi theo ngày
    int sumDaySpendMoney = 0;
    bool ktDay = false;
    for (var categorySpend in dataGroupSpendCategory.docs) {
      var category = CategorySpend.fromJson(categorySpend.data() as Map<String, dynamic>)..id = categorySpend.id;
      if (ktDay == true) {
        bool ktDay = false;sumDaySpendMoney = 0;
      }
      for (var costSpend in dataGroupSendCost.docs) {
        var spend = CostSpend.formJson(costSpend.data() as Map<String, dynamic>)
          ..id = costSpend.id;
        if (category.idUser == idUser && spend.idUser == idUser &&
            category.id.toString() == spend.idCategorySpend.toString()&&
            spend.dateTime!.day.toString()==DateTime.now().day.toString()
        ) {
          sumDaySpendMoney = sumDaySpendMoney + spend.money;
          ktDay = true;
        }
      }
      if (ktDay == true) {
        if (sumDaySpendMoney != 0) {
          GroupBy groupBySpend = GroupBy(name: category.name, money: sumDaySpendMoney);
          groupByDaySpend.add(groupBySpend);
        }
      }
    }
    //group by tiền chi theo tháng
    int sumMothMoney = 0;
    bool ktMoth = false;
    for (var categorySpend in dataGroupSpendCategory.docs) {
      var category = CategorySpend.fromJson(categorySpend.data() as Map<String, dynamic>)..id = categorySpend.id;
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
    //Group by tiền chi theo năm
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
    //Group by tiền thu theo ngày
    int sumDayCollectMoney = 0;
    bool ktDayCollect = false;
    for (var categoryCollect in dataGroupCollectCategory.docs) {
      var category = CategoryCollect.fromJson(categoryCollect.data() as Map<String, dynamic>)..id = categoryCollect.id;
      if (ktDayCollect == true) {
        bool ktDayCollect = false;sumDayCollectMoney = 0;
      }
      for (var costCollect in dataGroupCollectCost.docs) {
        var collect = CostCollect.formJson(costCollect.data() as Map<String, dynamic>)
          ..id = costCollect.id;
        if (category.idUser == idUser && collect.idUser == idUser &&
            category.id.toString() == collect.idCategoryCollect.toString()&&
            collect.dateTime!.day.toString()==DateTime.now().day.toString()
        ) {
          sumDayCollectMoney = sumDayCollectMoney + collect.money;
          ktDayCollect = true;
        }
      }
      if (ktDayCollect == true) {
        if (sumDayCollectMoney != 0) {
          GroupBy groupByCollect = GroupBy(name: category.name, money: sumDayCollectMoney);
          groupByDayCollect.add(groupByCollect);
        }
      }
    }
    //Group tiền thu theo tháng
    int sumMothCollectMoney = 0;
    bool ktMothCollect = false;
    for (var categoryCollect in dataGroupCollectCategory.docs) {
      var category = CategoryCollect.fromJson(categoryCollect.data() as Map<String, dynamic>)..id = categoryCollect.id;
      if (ktMothCollect == true) {
        bool ktMothCollect = false;sumMothCollectMoney = 0;
      }
      for (var costCollect in dataGroupCollectCost.docs) {
        var collect = CostCollect.formJson(costCollect.data() as Map<String, dynamic>)
          ..id = costCollect.id;
        if (category.idUser == idUser && collect.idUser == idUser &&
            category.id.toString() == collect.idCategoryCollect.toString()&&
            collect.dateTime!.month.toString()==DateTime.now().month.toString()
        ) {
          sumMothCollectMoney = sumMothCollectMoney + collect.money;
          ktMothCollect = true;
        }
      }
      if (ktMothCollect == true) {
        if (sumMothCollectMoney != 0) {
          GroupBy groupByCollect = GroupBy(name: category.name, money: sumMothCollectMoney);
          groupByMothCollect.add(groupByCollect);
        }
      }
    }
    //Group by tiền thu theo năm
    int sumYearCollectMoney = 0;
    bool ktYearCollect = false;
    for (var categoryCollect in dataGroupCollectCategory.docs) {
      var category = CategoryCollect.fromJson(categoryCollect.data() as Map<String, dynamic>)..id = categoryCollect.id;
      if (ktYearCollect == true) {
        bool ktYearCollect = false;sumYearCollectMoney = 0;
      }
      for (var costCollect in dataGroupCollectCost.docs) {
        var collect = CostCollect.formJson(costCollect.data() as Map<String, dynamic>)
          ..id = costCollect.id;
        if (category.idUser == idUser && collect.idUser == idUser &&
            category.id.toString() == collect.idCategoryCollect.toString()&&
            collect.dateTime!.year.toString()==DateTime.now().year.toString()
        ) {
          sumYearCollectMoney = sumYearCollectMoney + collect.money;
          ktYearCollect = true;
        }
      }
      if (ktMothCollect == true) {
        if (sumYearCollectMoney != 0) {
          GroupBy groupByCollect = GroupBy(name: category.name, money: sumYearCollectMoney);
          groupByYearCollect.add(groupByCollect);
        }
      }
    }





    GetStatistical value =
    GetStatistical(
        groupSumSpendCollectDay:groupSumSpendCollectDay,
        groupSumSpendCollectMoth: groupSumSpendCollectMoth,
        groupSumSpendCollectYear: groupSumSpendCollectYear,
        groupBySpendDay: groupByDaySpend,
        groupBySpendMoth: groupByMothSpend,
        groupBySpendYear: groupByYearSpend,
        groupByCollectDay: groupByDayCollect,
      groupByCollectMoth: groupByMothCollect,
      groupByCollectYear: groupByYearCollect,
      sumLastDay: sumDaySpendLast,
      sumLastMoth: sumMothSpendLast,
        sumLastYear: sumYearSpendLast,
      sumDay: sumDaySpend,
      sumMoth: sumMothSpend,
      sumYear: sumYearSpend
    );
    return value;





  }
}