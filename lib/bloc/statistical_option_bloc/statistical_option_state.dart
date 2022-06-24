import 'package:equatable/equatable.dart';

import 'package:quan_ly_chi_tieu/models/statistical_option.dart';

//LoginState
abstract class StatisticalOptionState extends Equatable {
  const StatisticalOptionState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
// Trạng thái khởi tạo
class StatisticalInitialOptionState extends StatisticalOptionState {}

//Get Statistical
class GetStatisticalOptionLoadingState extends StatisticalOptionState {}
class GetStatisticalOptionLoadedState extends StatisticalOptionState {
  StatisticalOption statisticalOption;
  GetStatisticalOptionLoadedState({required this.statisticalOption});
}
class GetStatisticalOptionErrorState extends StatisticalOptionState {
  final String error;
  GetStatisticalOptionErrorState({required this.error});
}