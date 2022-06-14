import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_state.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_event.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/category_Collect.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class AddCategoryCollectScreen extends StatefulWidget {
  final dynamic arg;
  const AddCategoryCollectScreen({Key? key, this.arg}) : super(key: key);
  @override
  _AddCategoryCollectScreenState createState() =>
      _AddCategoryCollectScreenState();
}

class _AddCategoryCollectScreenState extends State<AddCategoryCollectScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  CategoryCollect? collectCollect;
  @override
  void initState() {
    if (widget.arg is CategoryCollect) {
      collectCollect = widget.arg as CategoryCollect?;
      _nameController.text = collectCollect!.name;
      _noteController.text = collectCollect!.note!;
      // TODO: implement initState
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: Center(
          child: Text(collectCollect == null
              ? "Thêm danh mục thu "
              : "Cập nhật danh mục thu"),
        ),
      ),
      body: BlocListener<CategoryCollectBloc, CategoryCollectState>(
        listener: (context, state) {
          if (state is CreateCategoryCollectLoadingState ||
              state is UpdateCategoryCollectLoadingState) {
            LoadingHelper.showLoading(context);
          } else if (state is CreateCategoryCollectSuccessState ||
              state is UpdateCategoryCollectSuccessState) {
            LoadingHelper.hideLoading(context);
            Navigator.pop(context);
            FunctionHelper.showSnackBar(
                context: context,
                title: collectCollect == null
                    ? 'Thêm danh mục thu thành công !'
                    : 'Cập nhật danh mục thu thành công !');
            BlocProvider.of<CategoryCollectBloc>(context).add(GetCategoryCollectsEvent());
          } else if (state is CreateCategoryCollectErrorState) {
            LoadingHelper.hideLoading(context);
            FunctionHelper.showSnackBar(context: context, title: state.error);
          } else if (state is UpdateCategoryCollectErrorState) {
            LoadingHelper.hideLoading(context);
            FunctionHelper.showSnackBar(context: context, title: state.error);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              TextField(
                focusNode: nameFocus,
                controller: _nameController,
                style: AppThemes.commonText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.workspaces_outline,
                    size: 30,
                  ),
                  hintText: 'Tên danh mục ',
                  hintStyle: AppThemes.commonText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: _noteController,
                  style: AppThemes.commonText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.notes,
                      size: 30,
                    ),
                    hintText: 'Chú thích',
                    hintStyle: AppThemes.commonText,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child: FlatButton(
                  color: AppColors.appColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_circle_down_sharp,
                        size: 28,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        collectCollect == null ? "Thêm" : "Cập nhật",
                        style:
                            AppThemes.commonText.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    var categoryCollect = CategoryCollect(
                        name: _nameController.text.trim(),
                        note: _noteController.text.trim());
                    if (_nameController.text.trim().isNotEmpty) {
                      if (collectCollect == null) {
                        BlocProvider.of<CategoryCollectBloc>(context).add(
                          CreateCategoryCollectEvent(
                              categoryCollect: categoryCollect),
                        );
                      } else {
                        categoryCollect.id = collectCollect?.id;
                        categoryCollect.idUser = collectCollect!.idUser;
                        BlocProvider.of<CategoryCollectBloc>(context).add(
                            UpdateCategoryCollectEvent(
                                categoryCollect: categoryCollect));
                      }
                    } else {
                      FunctionHelper.showSnackBar(
                        context: context,
                        title: 'Bạn cần nhập tên danh mục thu !',
                      );
                      FocusScope.of(context).requestFocus(nameFocus);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
