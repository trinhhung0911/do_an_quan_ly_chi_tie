import 'package:quan_ly_chi_tieu/services/statistical_option_services.dart';

class StatisticalOptionRepository {
  Future<dynamic> getStatisticalRepository({required int day,required int moth,required int year}) async {
    await StatisticalOptionService().getStatisticalOption(day: day, moth: moth, year: year);
  }
}