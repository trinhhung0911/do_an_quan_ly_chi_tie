import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';


abstract class CostSpendEvent extends Equatable {
  const CostSpendEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CreateCostSpendEvent extends CostSpendEvent {
  final CostSpend costSpend ;
  const CreateCostSpendEvent({required this.costSpend});
}

class GetCostCategorySpendsEvent extends CostSpendEvent{}

class GetCostSpendsEvent extends CostSpendEvent{}

class UpdateCostSpendEvent extends CostSpendEvent{
  final CostSpend costSpend ;
  const UpdateCostSpendEvent ({required this.costSpend});
}
class DeleteCostSpendEvent extends CostSpendEvent{
  final CostSpend costSpend;
  const DeleteCostSpendEvent({required this.costSpend});
}