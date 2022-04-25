import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/categor_spend.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class TypeSpendCard extends StatefulWidget {
  CategorySpend categorySpend;
  int index;
  TypeSpendCard(this.categorySpend, this.index, {Key? key}) : super(key: key);
  @override
  _TypeSpendCardState createState() => _TypeSpendCardState();
}

class _TypeSpendCardState extends State<TypeSpendCard> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CategorySpendBloc, CategorySpendState>(
      listener: (context, state) {
        if (state is DeleteCategorySpendLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is DeleteCategorySpendSuccessState) {
          LoadingHelper.hideLoading(context);
          BlocProvider.of<CategorySpendBloc>(context)
              .add(GetCategorySpendsEvent());
        } else if (state is DeleteCategorySpendErrorState) {
          LoadingHelper.hideLoading(context);
          FunctionHelper.showSnackBar(context: context, title: state.error);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.spendCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        child: InkWell(
          onTap: () async {
            var result = await Navigator.pushNamed(
              context,
              Constants.addTypeSpendScreen,
              arguments: widget.categorySpend,
            );
            if (result != null) {
              setState(
                () {
                  widget.categorySpend = result as CategorySpend;
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
                    'Bạn có muốn xóa danh mục chi ${widget.categorySpend.name} !');
            if (result == OkCancelResult.ok) {
              BlocProvider.of<CategorySpendBloc>(context).add(
                DeleteCategorySpendEvent(categorySpend: widget.categorySpend),
              );
              FunctionHelper.showSnackBar(
                context: context,
                title:
                    "Xóa danh muc chi ${widget.categorySpend.name} thành công !",
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.account_circle_outlined,
                size: 40,
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                widget.categorySpend.name,
                style: AppThemes.commonText,
              )
            ],
          ),
        ),
      ),
    );
  }
}
