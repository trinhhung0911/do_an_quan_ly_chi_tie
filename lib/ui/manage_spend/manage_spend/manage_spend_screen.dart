import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_event.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/cost_spend_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/refresh_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/input/input_search_spend.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import '../../../bloc/cost_spend_bloc/cost_spend_bloc.dart';
import '../../../bloc/cost_spend_bloc/cost_spend_state.dart';

class ManageSpendScreen extends StatefulWidget {
  const ManageSpendScreen({Key? key}) : super(key: key);
  static bool isFetch = false;
  static int indext = 0;
  @override
  _ManageSpendScreenState createState() => _ManageSpendScreenState();
}

List<CostSpend> costSpends = [];
List<CostSpend> empCostSpends = [];
List<CostSpend> empCostSpendsTmp = [];

final refreshKeyManageSpend = GlobalKey<RefreshIndicatorState>();

class _ManageSpendScreenState extends State<ManageSpendScreen> {
  @override
  void initState() {
    BlocProvider.of<CostSpendBloc>(context).add(GetCostSpendsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(
          child: Text('Quản lý chi'),
        ),
        centerTitle: true,
      ),
      body: RefreshWidget(
        onRefresh: refresh,
        keyRefresh: refreshKeyManageSpend,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              InputSearch(searchName),
              BlocConsumer<CostSpendBloc, CostSpendState>(
                buildWhen: (context, state) {
                  return state is GetCostSpendLoadingState ||
                      state is GetCostSpendLoadedState ||
                      state is GetCostSpendErrorState;
                },
                builder: (context, state) {
                  if (state is GetCostSpendLoadingState) {
                    LoadingHelper.showLoading(context);
                  } else if (state is GetCostSpendLoadedState) {
                    LoadingHelper.hideLoading(context);
                    costSpends = state.costSpend;
                    if (!ManageSpendScreen.isFetch) {
                      if (ManageSpendScreen.indext == 0) {
                        empCostSpends = costSpends;
                        empCostSpendsTmp = empCostSpends;
                      } else if (ManageSpendScreen.indext == 1) {
                        final suggestions = costSpends
                            .where((costSpends) =>
                                costSpends.dateTime!.day.toString() ==
                                DateTime.now().day.toString())
                            .toList();
                        empCostSpends = suggestions;
                        empCostSpendsTmp = empCostSpends;
                      } else if (ManageSpendScreen.indext == 2) {
                        final suggestions = costSpends
                            .where((costSpends) =>
                                costSpends.dateTime!.month.toString() ==
                                DateTime.now().month.toString())
                            .toList();
                        empCostSpends = suggestions;
                        empCostSpendsTmp = empCostSpends;
                      } else if (ManageSpendScreen.indext == 3) {
                        final suggestions = costSpends
                            .where((costSpends) =>
                                costSpends.dateTime!.year.toString() ==
                                DateTime.now().year.toString())
                            .toList();
                        empCostSpends = suggestions;
                        empCostSpendsTmp = empCostSpends;
                      }
                      ManageSpendScreen.isFetch = true;
                    }
                    return empCostSpends.isNotEmpty
                        ? Column(
                            children: [
                              ListView.builder(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: empCostSpends.length,
                                itemBuilder: (context, index) =>
                                    CostSpendCard(empCostSpends[index], index),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 250),
                            child: Center(
                              child: Text(
                                'Chưa có khoản chi !',
                                style: AppThemes.commonText,
                              ),
                            ),
                          );
                  }
                  return Container();
                },
                listener: (context, state) {
                  if (state is GetCostSpendErrorState) {
                    LoadingHelper.hideLoading(context);
                    FunctionHelper.showSnackBar(
                        context: context, title: state.error);
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result =
              await Navigator.pushNamed(context, Constants.addSpendScreen);
          if (result != null) {
            setState(
              () {
                costSpends.add(result as CostSpend);
              },
            );
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.appColor,
        heroTag: "btn_qlct",
      ),
      drawer: DrawerItem(
        email: HomeScreen.email,
      ),
    );
  }

  Future<void> refresh() async {
    refreshKeyManageSpend.currentState?.show();
    await Future.delayed(const Duration(microseconds: 400));
    InputSearch.textSearchController.clear();
    if (InputSearch.dropDownValue.compareTo(InputSearch.items[0]) == 0) {
      ManageSpendScreen.indext = 0;
      ManageSpendScreen.isFetch = false;
    }
    if (InputSearch.dropDownValue.compareTo(InputSearch.items[1]) == 0) {
      ManageSpendScreen.indext = 1;
      ManageSpendScreen.isFetch = false;
    }
    if (InputSearch.dropDownValue.compareTo(InputSearch.items[2]) == 0) {
      ManageSpendScreen.indext = 2;
      ManageSpendScreen.isFetch = false;
    }
    if (InputSearch.dropDownValue.compareTo(InputSearch.items[3]) == 0) {
      ManageSpendScreen.indext = 3;
      ManageSpendScreen.isFetch = false;
    }
    BlocProvider.of<CostSpendBloc>(context).add(GetCostSpendsEvent());
  }

  searchName(String query) {
    final suggestions = empCostSpendsTmp.where((costSpend) {
      final name = costSpend.nameCategorySpend.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(
      () {
        empCostSpends = suggestions;
      },
    );
  }
}
