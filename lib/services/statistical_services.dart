import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
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
    GroupBy   groupSumCollectDay=new GroupBy(name: 'Tổng thu ',money: sumDayCollect);
    GroupBy   groupSumSpendDay=new GroupBy(name: 'Tổng chi ',money: sumDaySpend);
    groupSumSpendCollectDay.add(groupSumSpendDay);
    groupSumSpendCollectDay.add(groupSumCollectDay);
    print("-----------------");
    print(groupSumSpendCollectDay);



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
    GroupBy   groupSumCollectMoth=new GroupBy(name: 'Tổng thu ',money: sumMonthCollect);
    GroupBy   groupSumSpendMoth=new GroupBy(name: 'Tổng chi ',money: sumMothSpend);
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
    GroupBy   groupSumCollectYear=new GroupBy(name: 'Tổng thu ',money: sumYearCollect);
    GroupBy   groupSumSpendYear=new GroupBy(name: 'Tổng chi ',money: sumYearSpend);
    groupSumSpendCollectYear.add(groupSumCollectYear);
    groupSumSpendCollectYear.add(groupSumSpendYear);
    print("-----------------");
    print(sumYearCollect);
    print(sumYearSpend);
    print(groupSumSpendCollectYear.length);


    GetStatistical value =
    GetStatistical(
        groupSumSpendCollectDay:groupSumSpendCollectDay,
        groupSumSpendCollectMoth: groupSumSpendCollectMoth,
        groupSumSpendCollectYear: groupSumSpendCollectYear
    );
    return value;





  }
}