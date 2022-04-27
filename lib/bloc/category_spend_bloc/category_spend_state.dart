import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';

abstract class CategorySpendState extends Equatable {
  const CategorySpendState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
//CategorySpend
class SpendInitialState extends CategorySpendState {}
// CreateCategorySpend
class CreateCategorySpendLoadingState extends CategorySpendState {}
class CreateCategorySpendSuccessState extends CategorySpendState {}
class CreateCategorySpendErrorState extends CategorySpendState {
  final String error;
  const CreateCategorySpendErrorState({required this.error});
}
//GetCategorySpend
class GetCategorySpendLoadingState extends CategorySpendState {}
class GetCategorySpendLoadedState extends CategorySpendState {
  final List<CategorySpend> categorySpend;
 const GetCategorySpendLoadedState({required this.categorySpend});
}
class GetCategorySpendErrorState extends CategorySpendState {
  final String error;
  const GetCategorySpendErrorState({required this.error});
}

//UpdateCategorySpend
class UpdateCategorySpendLoadingState extends CategorySpendState {}
class UpdateCategorySpendSuccessState extends CategorySpendState {}
class UpdateCategorySpendErrorState extends CategorySpendState {
  final String error;
  const UpdateCategorySpendErrorState({required this.error});
}
//Delete
class DeleteCategorySpendLoadingState extends CategorySpendState {}
class DeleteCategorySpendSuccessState extends CategorySpendState {}
class DeleteCategorySpendErrorState extends CategorySpendState {
  final String error;
  const DeleteCategorySpendErrorState({required this.error});
}