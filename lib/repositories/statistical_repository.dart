import 'package:quan_ly_chi_tieu/models/get_statistical.dart';
import 'package:quan_ly_chi_tieu/services/statistical_services.dart';
class StatisticalRepository{
  Future<GetStatistical> getStatistical() async {
    return await StatisticalServices().getStatistical();
  }


}