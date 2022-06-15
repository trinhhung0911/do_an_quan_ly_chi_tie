import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_state.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_event.dart';
import 'package:quan_ly_chi_tieu/models/category_Collect.dart';
import 'package:quan_ly_chi_tieu/repositories/category_collect_repository.dart';


class CategoryCollectBloc extends Bloc<CategoryCollectEvent, CategoryCollectState> {
  final CategoryCollectRepository categoryCollectRepository;
  CategoryCollectBloc({required this.categoryCollectRepository})
      : super(CollectInitialState());
  @override
  Stream<CategoryCollectState> mapEventToState(CategoryCollectEvent event) async* {
    if (event is CreateCategoryCollectEvent) {
      yield* _mapCreateCategoryCollectToState(event);

    } else if (event is GetCategoryCollectsEvent) {
      yield* _mapGetCategoryCollectsToState(event);

    } else if (event is UpdateCategoryCollectEvent) {
      yield* _mapUpdateCategoryCollectToState(event);
    } else if (event is DeleteCategoryCollectEvent) {
      yield* _mapDeleteCategoryCollectToState(event);
    }
  }

  Stream<CategoryCollectState> _mapCreateCategoryCollectToState(
      CreateCategoryCollectEvent event) async* {
    yield CreateCategoryCollectLoadingState();
    try {
    await categoryCollectRepository.createCategoryCollect(
          categoryCollect: event.categoryCollect);
     yield CreateCategoryCollectSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const CreateCategoryCollectErrorState(
          error: 'Thêm danh mục thu thất bại !');
    }
  }

  Stream<CategoryCollectState> _mapGetCategoryCollectsToState(
      GetCategoryCollectsEvent event) async* {
    yield GetCategoryCollectLoadingState();
    try {
      final List<CategoryCollect> categoryCollect =
      await categoryCollectRepository.getCategoryCollects();
      yield GetCategoryCollectLoadedState(categoryCollect: categoryCollect);
    } on FirebaseAuthException catch (e) {
      yield const GetCategoryCollectErrorState(error: 'Lỗi');
    }
  }

  Stream<CategoryCollectState> _mapUpdateCategoryCollectToState(
      UpdateCategoryCollectEvent event) async* {
    yield UpdateCategoryCollectLoadingState();
    try {
      await categoryCollectRepository.updateCategoryCollect(
          categoryCollect: event.categoryCollect);
      yield UpdateCategoryCollectSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const UpdateCategoryCollectErrorState(error: 'Cập nhật thất bại !');
    }
  }

  Stream<CategoryCollectState> _mapDeleteCategoryCollectToState(
      DeleteCategoryCollectEvent event) async* {
    yield DeleteCategoryCollectLoadingState();
    try {
      await categoryCollectRepository.deleteCategoryCollect(
          categoryCollect: event.categoryCollect);
      yield DeleteCategoryCollectSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const DeleteCategoryCollectErrorState(error: 'Xóa thất bại !');
    }
  }
}