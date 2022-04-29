import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_event.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_state.dart';
import 'package:quan_ly_chi_tieu/models/category_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/repositories/cost_collect_repository.dart';

class CostCollectBloc extends Bloc<CostCollectEvent, CostCollectState> {
  final CostCollectRepository costCollectRepository;

  CostCollectBloc({required this.costCollectRepository})
      : super(CostCollectInitialState());

  @override
  Stream<CostCollectState> mapEventToState(CostCollectEvent event) async* {
    if (event is GetCostCategoryCollectsEvent) {
      yield* _mapGetCostCategoryCollectsToState(event);
    } else if (event is CreateCostCollectEvent) {
      yield* _mapCreateCostCollectToState(event);
    } else if (event is GetCostCollectsEvent) {
      yield* _mapGetCostCollectsToState(event);
      // }else if(event is DeleteCostCollectEvent){
      //   yield* _mapDeleteCostCollectState(event);
      // }else if(event is UpdateCostCollectEvent){
      //   yield* _mapUpdateCostCollectState(event);
      // }
    }
  }


  Stream<CostCollectState> _mapCreateCostCollectToState(
      CreateCostCollectEvent event) async* {
    yield CreateCostCollectLoadingState();
    try {
      await costCollectRepository.createCostCollect(
          costCollect: event.costCollect);
      yield CreateCostCollectSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const CreateCostCollectErrorState(
          error: 'Thêm khoản thu thất bại !');
    }
  }
  Stream<CostCollectState> _mapGetCostCollectsToState(
      GetCostCollectsEvent event) async* {
    yield GetCostCollectLoadingState();
    try {
      final List<CostCollect> costCollect = await costCollectRepository
          .getCostCollects();
      yield GetCostCollectLoadedState(costCollect: costCollect);
    } on FirebaseAuthException catch (e) {
      yield const GetCostCollectErrorState(error: 'Lỗi');
    }


  }

  Stream<CostCollectState> _mapGetCostCategoryCollectsToState(GetCostCategoryCollectsEvent event) async*{
    yield GetCostCategoryCollectLoadingState();
    try{
      final List<CategoryCollect> categoryCollect= await costCollectRepository.getCostCatgoryCollect();
      yield GetCostCategoryCollectLoadedState(categoryCollect: categoryCollect);
    }on FirebaseAuthException catch (e) {
      yield const GetCostCategoryCollectErrorState(error: 'Lỗi');
    }
  }
}