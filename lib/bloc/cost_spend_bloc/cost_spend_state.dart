import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';

abstract class CostSpendState extends Equatable {
  const CostSpendState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//CategorySpend
class CostSpendInitialState extends CostSpendState {}

//GetCostCategorySpend
class GetCostCategorySpendLoadingState extends CostSpendState {}
class GetCostCategorySpendLoadedState extends CostSpendState {
  final List<CategorySpend> categorySpend;
  const GetCostCategorySpendLoadedState({required this.categorySpend});
}
class GetCostCategorySpendErrorState extends CostSpendState {
  final String error;
  const GetCostCategorySpendErrorState({required this.error});
}
//CreateCostSpend
class CreateCostSpendLoadingState extends CostSpendState {}
class CreateCostSpendSuccessState extends CostSpendState {}
class CreateCostSpendErrorState extends CostSpendState {
  final String error;
  const CreateCostSpendErrorState({required this.error});
}
//GetCostSpend
class GetCostSpendLoadingState extends CostSpendState {}
class GetCostSpendLoadedState extends CostSpendState {
  final List<CostSpend> costSpend;
  const GetCostSpendLoadedState({required this.costSpend});
}
class GetCostSpendErrorState extends CostSpendState {
  final String error;
  const GetCostSpendErrorState({required this.error});
}

//DeleteCostSpend
class DeleteCostSpendLoadingState extends CostSpendState{}
class DeleteCostSpendSuccessState extends CostSpendState {}
class DeleteCostSpendErrorState extends CostSpendState {
  final String error;
  const DeleteCostSpendErrorState({required this.error});
}
//UpdateCostSpend
class UpdateCostSpendLoadingState extends CostSpendState{}
class UpdateCostSpendSuccessState extends CostSpendState {}
class UpdateCostSpendErrorState extends CostSpendState {
  final String error;
  const UpdateCostSpendErrorState({required this.error});
}
