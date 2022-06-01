import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/get_statistical.dart';

//LoginState
abstract class StatisticalState extends Equatable {
  const StatisticalState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
// Trạng thái khởi tạo
class StatisticalInitialState extends StatisticalState {}

//Get Statistical
class GetStatisticalLoadingState extends StatisticalState {}
class GetStatisticalLoadedState extends StatisticalState {
  GetStatistical getStatistical;
  GetStatisticalLoadedState({required this.getStatistical});
}
class GetStatisticalErrorState extends StatisticalState {
  final String error;
  const GetStatisticalErrorState({required this.error});
}