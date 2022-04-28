import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/category_Collect.dart';

abstract class CategoryCollectState extends Equatable {
  const CategoryCollectState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
//CategoryCollect
class CollectInitialState extends CategoryCollectState {}
// CreateCategoryCollect

class CreateCategoryCollectLoadingState extends CategoryCollectState {}
class CreateCategoryCollectSuccessState extends CategoryCollectState {}
class CreateCategoryCollectErrorState extends CategoryCollectState {
  final String error;
  const CreateCategoryCollectErrorState({required this.error});
}

//GetCategoryCollect
class GetCategoryCollectLoadingState extends CategoryCollectState {}
class GetCategoryCollectLoadedState extends CategoryCollectState {
  final List<CategoryCollect> categoryCollect;
  const GetCategoryCollectLoadedState({required this.categoryCollect});
}
class GetCategoryCollectErrorState extends CategoryCollectState {
  final String error;
  const GetCategoryCollectErrorState({required this.error});
}
//UpdateCategoryCollect
class UpdateCategoryCollectLoadingState extends CategoryCollectState {}
class UpdateCategoryCollectSuccessState extends CategoryCollectState {}
class UpdateCategoryCollectErrorState extends CategoryCollectState {
  final String error;
  const UpdateCategoryCollectErrorState({required this.error});
}
//Delete
class DeleteCategoryCollectLoadingState extends CategoryCollectState {}
class DeleteCategoryCollectSuccessState extends CategoryCollectState {}
class DeleteCategoryCollectErrorState extends CategoryCollectState {
  final String error;
  const DeleteCategoryCollectErrorState({required this.error});
}