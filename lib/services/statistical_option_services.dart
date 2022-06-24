import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/models/statistical_option.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';

class StatisticalOptionService {
  //get tất cả
  Future<StatisticalOption> getStatisticalOption(
      {required int day, required int moth, required int year}) async {
    List<CostSpend> costSpend = [];
    final List<CostCollect> costCollect = [];
    var idUser = await SecureStorage().getString(key: SecureStorage.userId);
    //getCostSpend
    CollectionReference costSpendCollection =
        FirebaseFirestore.instance.collection(CollectionName.costSpend.name);
    var data = await costSpendCollection.get();
    for (var item in data.docs) {
      var e = CostSpend.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser &&
          e.dateTime!.day.toString() == day.toString() &&
          e.dateTime!.month.toString() == moth.toString() &&
          e.dateTime!.year.toString() == year.toString()) {
        costSpend.add(e);
      }
    }
    //getCostCollect
    CollectionReference costCollectCollection =
        FirebaseFirestore.instance.collection(CollectionName.costCollect.name);
    var dataCollect = await costCollectCollection.get();
    for (var item in dataCollect.docs) {
      var e = CostCollect.formJson(item.data() as Map<String, dynamic>)
        ..id = item.id;
      if (e.idUser == idUser &&
          e.dateTime!.day.toString() == day.toString() &&
          e.dateTime!.month.toString() == moth.toString() &&
          e.dateTime!.year.toString() == year.toString()) {
        costCollect.add(e);
      }
    }
    StatisticalOption value =
        StatisticalOption(costSpend: costSpend, costCollect: costCollect);
    return value;
  }
}
