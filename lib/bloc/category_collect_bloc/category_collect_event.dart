import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/category_Collect.dart';

abstract class CategoryCollectEvent extends Equatable {
  const CategoryCollectEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//CategoryCollect
class CreateCategoryCollectEvent extends CategoryCollectEvent {
  final CategoryCollect categoryCollect;
  const CreateCategoryCollectEvent({required this.categoryCollect});
}
class GetCategoryCollectsEvent extends CategoryCollectEvent {}
class UpdateCategoryCollectEvent extends CategoryCollectEvent {
  final CategoryCollect categoryCollect;
  const UpdateCategoryCollectEvent({required this.categoryCollect});
}
class DeleteCategoryCollectEvent extends CategoryCollectEvent {
  final CategoryCollect categoryCollect;
  const DeleteCategoryCollectEvent({required this.categoryCollect});
}
