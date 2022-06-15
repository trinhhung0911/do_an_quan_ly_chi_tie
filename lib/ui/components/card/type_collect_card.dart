import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_event.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/category_Collect.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class TypeCollectCard extends StatefulWidget {
  CategoryCollect categoryCollect;
  int index;
  TypeCollectCard(this.categoryCollect, this.index, {Key? key})
      : super(key: key);
  @override
  _TypeCollectCardState createState() => _TypeCollectCardState();
}

class _TypeCollectCardState extends State<TypeCollectCard> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryCollectBloc, CategoryCollectState>(
      listener: (context, state) {
        if (state is DeleteCategoryCollectLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is DeleteCategoryCollectSuccessState) {
          LoadingHelper.hideLoading(context);
          BlocProvider.of<CategoryCollectBloc>(context)
              .add(GetCategoryCollectsEvent());
          FunctionHelper.showSnackBar(
            context: context,
            title: "Xóa danh muc thu ${widget.categoryCollect.name} thành công !",
          );
        } else if (state is DeleteCategoryCollectErrorState) {
          LoadingHelper.hideLoading(context);
          FunctionHelper.showSnackBar(context: context, title: state.error);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:  const Color(0xFFFAF5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16,right: 16),
        margin: EdgeInsets.only(top: 10),

        child: InkWell(
          onTap: () async {
            var result = await Navigator.pushNamed(
              context,
              Constants.addCategoryCollectScreen,
              arguments: widget.categoryCollect,
            );
            if (result != null) {
              setState(
                    () {
                  widget.categoryCollect = result as CategoryCollect;
                },
              );
            }
          },
          onLongPress: () async {
            var result = await showOkCancelAlertDialog(
                context: context,
                title: "Thông báo ",
                okLabel: "Đồng ý",
                cancelLabel: "Hủy",
                message:
                'Bạn có muốn xóa danh mục thu ${widget.categoryCollect.name} !');
            if (result == OkCancelResult.ok) {
              BlocProvider.of<CategoryCollectBloc>(context).add(
                DeleteCategoryCollectEvent(categoryCollect: widget.categoryCollect),);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.archive_outlined,
                size: 40,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  widget.categoryCollect.name,
                  style: AppThemes.commonText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}