import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_event.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/storage/secure_storge.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

import '../category_collect/category_collect_screen.dart';

class AddCostCollectScreen extends StatefulWidget {
  final dynamic arg;
  const AddCostCollectScreen({Key? key, this.arg}) : super(key: key);
  @override
  _AddCostCollectScreenState createState() => _AddCostCollectScreenState();
}

class _AddCostCollectScreenState extends State<AddCostCollectScreen> {
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _categoryCollectController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final refreshKeyCategory = GlobalKey<RefreshIndicatorState>();
  CostCollect? costCollect;
  late String idCategoryCollect;
  @override
  void initState() {
    if (widget.arg is CostCollect) {
      costCollect = widget.arg as CostCollect?;
      _moneyController.text = costCollect!.money.toString();
      _categoryCollectController.text = costCollect!.nameCategoryCollect;
      _dateController.text = costCollect!.dateTime.toString().split(' ')[0];
      _noteController.text = costCollect!.note.toString();
      idCategoryCollect=costCollect!.idCategoryCollect.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: Center(
          child: Text(
              costCollect == null ? 'Thêm nguồn thu' : 'Cập nhật nguồn thu'),
        ),
      ),
      body: BlocListener<CostCollectBloc, CostCollectState>(
        listener: (context, state) {
          if (state is CreateCostCollectLoadingState ||
              state is UpdateCostCollectLoadingState) {
            LoadingHelper.showLoading(context);
          } else if (state is CreateCostCollectSuccessState ||
              state is UpdateCostCollectSuccessState) {
            LoadingHelper.hideLoading(context);
            Navigator.pop(context);
            FunctionHelper.showSnackBar(
                context: context,
                title: costCollect == null
                    ? 'Thêm khoản thu thành công !'
                    : 'Cập nhật khoản thu thành công !');
            BlocProvider.of<CostCollectBloc>(context)
                .add(GetCostCollectsEvent());
          } else if (state is CreateCostCollectErrorState) {
            LoadingHelper.hideLoading(context);
            FunctionHelper.showSnackBar(context: context, title: state.error);
          } else if (state is UpdateCostCollectErrorState) {
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
                      onTap: () {
                        _showDialog();
                      },
                      child: TextField(
                        controller: _categoryCollectController,
                        style: AppThemes.commonText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.category,
                            size: 30,
                          ),
                          hintText: 'Chọn nguồn thu',
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
                child: FlatButton(
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
                        costCollect == null ? "Ghi" : 'Cập nhật',
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
                  onPressed: () async {
                    if (_moneyController.text.isNotEmpty &&
                        _categoryCollectController.text.isNotEmpty) {
                      var idUser = await SecureStorage()
                          .getString(key: SecureStorage.userId);
                      var costCollect1 = CostCollect(
                        money: int.parse(_moneyController.text.trim()),
                        nameCategoryCollect:
                            _categoryCollectController.text.trim(),
                        note: _noteController.text.trim(),
                        idCategoryCollect: idCategoryCollect,
                        idUser: idUser,
                        dateTime: _dateController.text.isEmpty
                            ? DateTime.now()
                            : FunctionHelper.formatDateText(
                                _dateController.text.trim()),
                      );
                      if (costCollect == null) {
                        BlocProvider.of<CostCollectBloc>(context).add(
                            CreateCostCollectEvent(costCollect: costCollect1));
                      } else {
                        costCollect1.id = costCollect?.id;
                        costCollect1.idUser = costCollect!.idUser;
                        BlocProvider.of<CostCollectBloc>(context).add(
                            UpdateCostCollectEvent(costCollect: costCollect1));
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
          child: Text('Chọn loại thu'),
        ),
        children: [
          SizedBox(
            height: 150,
            width: 200,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  categoryCollects.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: categoryCollects.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                _categoryCollectController.text =
                                    categoryCollects[index].name;
                                idCategoryCollect = categoryCollects[index].id!;
                                Navigator.pop(context);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Center(
                                child: Text(
                                  categoryCollects[index].name,
                                  style: AppThemes.commonText,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            "Chưa có danh mục thu !",
                            style: AppThemes.commonText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await Navigator.pushNamed(
                  context, Constants.addCategoryCollectScreen);
              Navigator.pop(context);
            },
            child: const Text('Thêm danh mục thu'),
          )
        ],
      ),
    );
  }
}
