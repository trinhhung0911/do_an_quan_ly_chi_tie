import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/category_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';


abstract class CostCollectState extends Equatable {
  const CostCollectState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//CategoryCollect
class CostCollectInitialState extends CostCollectState {}

//GetCostCategoryCollect
class GetCostCategoryCollectLoadingState extends CostCollectState {}
class GetCostCategoryCollectLoadedState extends CostCollectState {
  // final List<CategoryCollect> categoryCollect;
  final List<CategoryCollect> categoryCollect;
  const GetCostCategoryCollectLoadedState({required this.categoryCollect});
}
class GetCostCategoryCollectErrorState extends CostCollectState {
  final String error;
  const GetCostCategoryCollectErrorState({required this.error});
}

// //CreateCostCollect
class CreateCostCollectLoadingState extends CostCollectState {}
class CreateCostCollectSuccessState extends CostCollectState {}
class CreateCostCollectErrorState extends CostCollectState {
  final String error;
  const CreateCostCollectErrorState({required this.error});
}
// //GetCostCollect
class GetCostCollectLoadingState extends CostCollectState {}
class GetCostCollectLoadedState extends CostCollectState {
  final List<CostCollect> costCollect;
  const GetCostCollectLoadedState({required this.costCollect});
}
class GetCostCollectErrorState extends CostCollectState {
  final String error;
  const GetCostCollectErrorState({required this.error});
}

//
//DeleteCostCollect
class DeleteCostCollectLoadingState extends CostCollectState{}
class DeleteCostCollectSuccessState extends CostCollectState {}
class DeleteCostCollectErrorState extends CostCollectState {
  final String error;
  const DeleteCostCollectErrorState({required this.error});
}
//UpdateCostCollect
class UpdateCostCollectLoadingState extends CostCollectState{}
class UpdateCostCollectSuccessState extends CostCollectState {}
class UpdateCostCollectErrorState extends CostCollectState {
  final String error;
  const UpdateCostCollectErrorState({required this.error});
}
