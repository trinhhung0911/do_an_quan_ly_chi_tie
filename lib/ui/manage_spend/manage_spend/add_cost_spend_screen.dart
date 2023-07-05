import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';
import 'package:quan_ly_chi_tieu/ui/manage_spend/category_spend/category_spend_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class AddSpendScreen extends StatefulWidget {
  final dynamic arg;
  const AddSpendScreen({Key? key, this.arg}) : super(key: key);
  @override
  _AddSpendScreenState createState() => _AddSpendScreenState();
}

class _AddSpendScreenState extends State<AddSpendScreen> {
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _categorySpendController =
  TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late String idCategorySpend;
  final refreshKeyCategory = GlobalKey<RefreshIndicatorState>();
  CostSpend? costSpend;
  late int maxMin;
  @override
  void initState() {
    if (widget.arg is CostSpend) {
      costSpend = widget.arg as CostSpend?;
      _moneyController.text = costSpend!.money.toString();
      _categorySpendController.text = costSpend!.nameCategorySpend;
      _dateController.text = costSpend!.dateTime.toString().split(' ')[0];
      _noteController.text = costSpend!.note.toString();
      idCategorySpend=costSpend!.idCategorySpend.toString();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: Center(
          child:
          Text(costSpend == null ? 'Thêm khoản chi' : 'Cập nhật khoản chi'),
        ),
      ),
      body: BlocListener<CostSpendBloc, CostSpendState>(
        listener: (context, state) {
          if (state is CreateCostSpendLoadingState ||
              state is UpdateCostSpendLoadingState) {
            LoadingHelper.showLoading(context);
          } else if (state is CreateCostSpendSuccessState ||
              state is UpdateCostSpendSuccessState) {
            LoadingHelper.hideLoading(context);

            FunctionHelper.showSnackBar(
                context: context,
                title: costSpend == null
                    ? 'Thêm khoản chi thành công !'
                    : 'Cập nhật khoản chi thành công !');
            Navigator.pop(context);
            BlocProvider.of<CostSpendBloc>(context).add(GetCostSpendsEvent());
          } else if (state is CreateCostSpendErrorState) {
            LoadingHelper.hideLoading(context);
            FunctionHelper.showSnackBar(context: context, title: state.error);
          }
          else if (state is UpdateCostSpendErrorState) {
            LoadingHelper.hideLoading(context);
            FunctionHelper.showSnackBar(context: context, title: state.error);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 24, right: 24, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Số tiền',
                      style: AppThemes.commonText,
                    ),
                    TextField(
                      controller: _moneyController,
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      style: AppThemes.commonText,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.monetization_on,
                            size: 30,
                          ),
                          hintText: '0',
                          hintStyle: AppThemes.commonText,
                          suffixText: 'đ',
                          suffixStyle: AppThemes.commonText),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(
                    top: 10, left: 24, right: 24, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        await refresh();
                        _showDialog();
                      },
                      child: TextField(
                        controller: _categorySpendController,
                        style: AppThemes.commonText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.category,
                            size: 30,
                          ),
                          hintText: 'Chọn loại chi',
                          hintStyle: AppThemes.commonText,
                          enabled: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: InkWell(
                        onTap: () async {
                          var result = await FunctionHelper.selectDate(
                              context: context, lastDate: DateTime.now());
                          if (result != null) {
                            setState(() {
                              _dateController.text =
                                  FunctionHelper.formatDate(result);
                            });
                          }
                        },
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: AppThemes.commonText,
                          controller: _dateController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              size: 30,
                            ),
                            hintText: 'Chọn ngày',
                            hintStyle: AppThemes.commonText,
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _noteController,
                      keyboardType: TextInputType.number,
                      style: AppThemes.commonText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.subject,
                          size: 30,
                        ),
                        hintText: 'Chú thích',
                        hintStyle: AppThemes.commonText,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24),
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 35),
                child: CupertinoButton(
                  color: AppColors.appColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_circle_down_sharp,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        costSpend == null ? "Ghi" : 'Cập nhật',
                        style:
                        AppThemes.commonText.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    if (_moneyController.text.isNotEmpty &&
                        _categorySpendController.text.isNotEmpty) {
                      if(int.parse(_moneyController.text.toString())<=maxMin||maxMin==0){
                        var idUser = await SecureStorage()
                            .getString(key: SecureStorage.userId);
                        var costSpend1 = CostSpend(
                          money: int.parse(_moneyController.text.trim()),
                          nameCategorySpend: _categorySpendController.text.trim(),
                          note: _noteController.text.trim(),
                          idCategorySpend: idCategorySpend,
                          idUser: idUser,
                          dateTime: _dateController.text.isEmpty ? DateTime.now() : FunctionHelper.formatDateText(
                            _dateController.text.trim(),),
                        );
                        if (costSpend == null) {
                          BlocProvider.of<CostSpendBloc>(context)
                              .add(CreateCostSpendEvent(costSpend: costSpend1));
                        } else {
                          costSpend1.id = costSpend?.id;
                          costSpend1.idUser = costSpend!.idUser;
                          BlocProvider.of<CostSpendBloc>(context)
                              .add(UpdateCostSpendEvent(costSpend: costSpend1));
                        }
                      }else{
                        FunctionHelper.showSnackBar(
                            context: context, title: "Qúa hạn mức cho phép");
                      }
                    } else {
                      FunctionHelper.showSnackBar(
                          context: context, title: "Nhập đầy đủ thông tin !");
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

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: const Center(
          child: Text('Chọn loại chi'),
        ),
        children: [
          SizedBox(
            height: 150,
            width: 200,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  categorySpends.isNotEmpty
                      ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: categorySpends.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          _categorySpendController.text = categorySpends[index].name;
                          idCategorySpend = categorySpends[index].id!;
                          maxMin=categorySpends[index].maximum!;
                          Navigator.pop(context);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Column(

                          children: [
                            const Divider(),
                            Center(
                              child: Text(
                                categorySpends[index].name,
                                style: AppThemes.commonText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : Center(
                    child: Text(
                      "Chưa có danh mục chi !",
                      style: AppThemes.commonText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, Constants.addTypeSpendScreen);
                Navigator.pop(context);
              },
              child: const Text('Thêm danh mục chi'))
        ],
      ),
    );
  }
  Future<void> refresh() async {
    refreshKeyCategory.currentState?.show();
    await Future.delayed(const Duration(microseconds: 400));
    BlocProvider.of<CategorySpendBloc>(context).add(GetCategorySpendsEvent());
  }
}