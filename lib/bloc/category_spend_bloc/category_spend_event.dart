import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';

abstract class CategorySpendEvent extends Equatable {
  const CategorySpendEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//CategorySpend
class CreateCategorySpendEvent extends CategorySpendEvent {
  final CategorySpend categorySpend;
  const CreateCategorySpendEvent({required this.categorySpend});
}
class GetCategorySpendsEvent extends CategorySpendEvent {}
class UpdateCategorySpendEvent extends CategorySpendEvent {
  final CategorySpend categorySpend;
  const UpdateCategorySpendEvent({required this.categorySpend});
}
class DeleteCategorySpendEvent extends CategorySpendEvent {
  final CategorySpend categorySpend;
  const DeleteCategorySpendEvent({required this.categorySpend});
}
