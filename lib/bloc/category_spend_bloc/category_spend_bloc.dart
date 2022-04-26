import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_state.dart';
import 'package:quan_ly_chi_tieu/models/categor_spend.dart';
import 'package:quan_ly_chi_tieu/repositories/category_repository.dart';




class CategorySpendBloc extends Bloc<CategorySpendEvent, CategorySpendState> {
  final CategorySpendRepository categorySpendRepository;
  CategorySpendBloc({required this.categorySpendRepository}) : super(SpendInitialState());
  @override
  Stream<CategorySpendState> mapEventToState(CategorySpendEvent event) async* {
    if (event is CreateCategorySpendEvent) {
      yield* _mapCreateCategorySpendToState(event);
    }else if(event is GetCategorySpendsEvent ){
      yield* _mapGetCategorySpendsToState(event);
    }else if (event is UpdateCategorySpendEvent) {
      yield* _mapUpdateCategorySpendToState(event);
    }else if(event is DeleteCategorySpendEvent){
      yield* _mapDeleteCategorySpendToState(event);
    }
  }

  Stream<CategorySpendState> _mapCreateCategorySpendToState(CreateCategorySpendEvent  event) async*{
    yield CreateCategorySpendLoadingState();
    try {
      await categorySpendRepository.createCategorySpend(categorySpend: event.categorySpend);
      yield CreateCategorySpendSuccessState();
    } on FirebaseAuthException catch (e) {
        yield const CreateCategorySpendErrorState(error: 'Thêm danh mục chi  thất bại !');
    }
  }
  Stream<CategorySpendState>  _mapGetCategorySpendsToState(GetCategorySpendsEvent event) async*{
    yield GetCategorySpendLoadingState();
    try {
      final List<CategorySpend> categorySpend = await categorySpendRepository.getCategorySpends();
      yield GetCategorySpendLoadedState(categorySpend: categorySpend);
    }on FirebaseAuthException catch (e) {
      yield const GetCategorySpendErrorState(error: 'Lỗi');
    }



  }
  Stream<CategorySpendState>  _mapUpdateCategorySpendToState(UpdateCategorySpendEvent event) async*{
    yield UpdateCategorySpendLoadingState();
    try {
      await categorySpendRepository.updateCategorySpend(categorySpend: event.categorySpend);
      yield  UpdateCategorySpendSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const UpdateCategorySpendErrorState(error: 'Cập nhật thất bại !');
    }


  }
  Stream<CategorySpendState>   _mapDeleteCategorySpendToState(DeleteCategorySpendEvent event) async*{
    yield DeleteCategorySpendLoadingState();
    try {
      await categorySpendRepository.deleteCategorySpend(categorySpend: event.categorySpend);
      yield DeleteCategorySpendSuccessState();
    } on FirebaseAuthException catch (e) {
      yield const DeleteCategorySpendErrorState(error: 'Xóa thất bại !');
    }

  }
}
