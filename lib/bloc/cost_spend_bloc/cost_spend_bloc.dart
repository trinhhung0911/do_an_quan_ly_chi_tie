import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_state.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/repositories/cost_spend_repository.dart';

class CostSpendBloc extends Bloc<CostSpendEvent, CostSpendState> {
  final CostSpendRepository costSpendRepository;
  CostSpendBloc({required this.costSpendRepository}) : super(CostSpendInitialState());
  @override
  Stream<CostSpendState> mapEventToState(CostSpendEvent event) async* {
    if (event is GetCostCategorySpendsEvent) {
      yield* _mapGetCostCategorySpendsToState(event);
    }else if(event is CreateCostSpendEvent ){
      yield* _mapCreateCostSpendToState(event);
    }else if(event is GetCostSpendsEvent){
      yield* _mapGetCostSpendsToState(event);
    }else if(event is DeleteCostSpendEvent){
      yield* _mapDeleteCostSpendState(event);
    }else if(event is UpdateCostSpendEvent){
      yield* _mapUpdateCostSpendState(event);
    }
  }

  Stream<CostSpendState> _mapGetCostCategorySpendsToState(GetCostCategorySpendsEvent event) async*{
    yield GetCostCategorySpendLoadingState();
    try {
      final List<CategorySpend> categorySpend = await costSpendRepository.getCostCategorySpends();
      yield GetCostCategorySpendLoadedState(categorySpend: categorySpend);
    }on FirebaseAuthException catch (e) {
      yield const GetCostCategorySpendErrorState(error: 'Lỗi');
    }



  }
  Stream<CostSpendState> _mapCreateCostSpendToState(CreateCostSpendEvent  event) async*{
    yield CreateCostSpendLoadingState();
    try {
      await costSpendRepository.createCostSpend(costSpend: event.costSpend);
      yield CreateCostSpendSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const CreateCostSpendErrorState(error: 'Thêm khoản chi  thất bại !');
    }
  }
  Stream<CostSpendState>  _mapGetCostSpendsToState(GetCostSpendsEvent event) async*{
    yield GetCostSpendLoadingState();
    try {
      final List<CostSpend> costSpend = await costSpendRepository.getCostSpends();
      yield GetCostSpendLoadedState(costSpend: costSpend);
    }on FirebaseAuthException catch (e) {
      yield const GetCostSpendErrorState(error: 'Lỗi');
    }



  }

  Stream<CostSpendState> _mapDeleteCostSpendState(DeleteCostSpendEvent event) async*{
    yield DeleteCostSpendLoadingState();
    try {
      await costSpendRepository.deleteCostSpend(costSpend: event.costSpend);
      yield DeleteCostSpendSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const DeleteCostSpendErrorState(error: 'Xóa thất bại !');
    }
  }
  Stream<CostSpendState>  _mapUpdateCostSpendState(UpdateCostSpendEvent event) async*{
    yield UpdateCostSpendLoadingState();
    try {
      await costSpendRepository.updateCostSpend(costSpend: event.costSpend);
      yield  UpdateCostSpendSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const UpdateCostSpendErrorState(error: 'Cập nhật thất bại !');
    }


  }
}