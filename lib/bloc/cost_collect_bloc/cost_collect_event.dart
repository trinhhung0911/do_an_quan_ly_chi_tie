import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';


abstract class CostCollectEvent extends Equatable {
  const CostCollectEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CreateCostCollectEvent extends CostCollectEvent {
  final CostCollect costCollect ;
  const CreateCostCollectEvent({required this.costCollect});
}

class GetCostCategoryCollectsEvent extends CostCollectEvent{}

class GetCostCollectsEvent extends CostCollectEvent{}
//
// class UpdateCostCollectEvent extends CostCollectEvent{
//   final CostCollect costCollect ;
//   const UpdateCostCollectEvent ({required this.costCollect});
// }
// class DeleteCostCollectEvent extends CostCollectEvent{
//   final CostCollect costCollect;
//   const DeleteCostCollectEvent({required this.costCollect});
// }