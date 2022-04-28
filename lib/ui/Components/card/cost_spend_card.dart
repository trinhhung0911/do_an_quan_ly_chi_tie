import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_state.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class CostSpendCard extends StatefulWidget {
  CostSpend costSpend;
  int index;
  CostSpendCard(this.costSpend, this.index, {Key? key}) : super(key: key);
  @override
  _CostSpendCardState createState() => _CostSpendCardState();
}

class _CostSpendCardState extends State<CostSpendCard> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CostSpendBloc, CostSpendState>(
      listener: (context, state) {
        if (state is DeleteCostSpendLoadingState) {
          LoadingHelper.showLoading(context);
        }
        else if (state is DeleteCostSpendSuccessState) {
          LoadingHelper.hideLoading(context);
          FunctionHelper.showSnackBar(
            context: context,
            title: "Xóa khoản chi thành công !",
          );
          BlocProvider.of<CostSpendBloc>(context).add(GetCostSpendsEvent());
        }
        else if (state is DeleteCostSpendErrorState) {
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
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8,right: 16),
        child: InkWell(
          onTap: () async {
            var result = await Navigator.pushNamed(
              context,
              Constants.addSpendScreen,
              arguments: widget.costSpend,
            );
            if (result != null) {
              setState(
                () {
                  widget.costSpend = result as CostSpend;
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
                    'Bạn có muốn xóa khoản chi  ${widget.costSpend.nameCategorySpend} !');
            if (result == OkCancelResult.ok) {
              BlocProvider.of<CostSpendBloc>(context).add(
                DeleteCostSpendEvent(costSpend: widget.costSpend),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.account_balance_wallet_outlined,
                size: 40,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.costSpend.nameCategorySpend,
                style: AppThemes.lightText.copyWith(color: Colors.black),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.costSpend.dateTime.toString().split(' ')[0],
                style: AppThemes.lightText.copyWith(color: Colors.black),

              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.costSpend.money.toString().split(' ')[0],
                style: AppThemes.lightText.copyWith(color: Colors.black),

              )
            ],
          ),
        ),
      ),
    );
  }
}
