import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_event.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/cost_collect_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/refresh_card.dart';
import 'package:quan_ly_chi_tieu/ui/components/input/input_search_collect.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class ManageCollectScreen extends StatefulWidget {
  static bool isFetch = false;
  static int indext = 0;
  const ManageCollectScreen({Key? key}) : super(key: key);
  @override
  _ManageCollectScreenState createState() => _ManageCollectScreenState();
}

List<CostCollect> costCollects = [];
List<CostCollect> empCostCollects = [];
List<CostCollect> empCostCollectsTmp = [];

final refreshKeyManageCollect = GlobalKey<RefreshIndicatorState>();

class _ManageCollectScreenState extends State<ManageCollectScreen> {
  @override
  void initState() {
    BlocProvider.of<CostCollectBloc>(context).add(GetCostCollectsEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(
          child: Text('Quản lý thu'),
        ),
        centerTitle: true,
      ),
      body: RefreshWidget(
        onRefresh: refresh,
        keyRefresh: refreshKeyManageCollect,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              InputSearchCollect(searchName),
              BlocConsumer<CostCollectBloc, CostCollectState>(
                buildWhen: (context, state) {
                  return state is GetCostCollectLoadingState ||
                      state is GetCostCollectLoadedState ||
                      state is GetCostCollectErrorState;
                },
                builder: (context, state) {
                  if (state is GetCostCollectLoadingState) {
                    LoadingHelper.showLoading(context);
                  } else if (state is GetCostCollectLoadedState) {
                    LoadingHelper.hideLoading(context);
                    costCollects = state.costCollect;
                    if (!ManageCollectScreen.isFetch) {
                      if (ManageCollectScreen.indext == 0) {
                        empCostCollects = costCollects;
                        empCostCollectsTmp = empCostCollects;
                      } else if (ManageCollectScreen.indext == 1) {
                        final suggestions = costCollects
                            .where((costCollects) =>
                                costCollects.dateTime!.day.toString() ==
                                DateTime.now().day.toString())
                            .toList();
                        empCostCollects = suggestions;
                        empCostCollectsTmp = empCostCollects;
                      } else if (ManageCollectScreen.indext == 2) {
                        final suggestions = costCollects
                            .where((costCollects) =>
                                costCollects.dateTime!.month.toString() ==
                                DateTime.now().month.toString())
                            .toList();
                        empCostCollects = suggestions;
                        empCostCollectsTmp = empCostCollects;
                      } else if (ManageCollectScreen.indext == 3) {
                        final suggestions = costCollects
                            .where((costCollects) =>
                                costCollects.dateTime!.year.toString() ==
                                DateTime.now().year.toString())
                            .toList();
                        empCostCollects = suggestions;
                        empCostCollectsTmp = empCostCollects;
                      }
                      ManageCollectScreen.isFetch = true;
                    }
                    return empCostCollects.isNotEmpty
                        ? Column(
                            children: [
                              ListView.builder(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: empCostCollects.length,
                                  itemBuilder: (context, index) =>
                                      CostCollectCard(
                                          empCostCollects[index], index)),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 250),
                            child: Center(
                              child: Text(
                                'Chưa có khoản thu !',
                                style: AppThemes.commonText,
                              ),
                            ),
                          );
                  }
                  return Container();
                },
                listener: (context, state) {
                  if (state is GetCostCollectErrorState) {
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
          var result = await Navigator.pushNamed(
              context, Constants.addCostCollectScreen);
          if (result != null) {
            setState(
              () {
                costCollects.add(result as CostCollect);
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
    refreshKeyManageCollect.currentState?.show();
    await Future.delayed(const Duration(microseconds: 400));
    InputSearchCollect.textSearchController.clear();
    if (InputSearchCollect.dropDownValue
            .compareTo(InputSearchCollect.items[0]) ==
        0) {
      ManageCollectScreen.indext = 0;
      ManageCollectScreen.isFetch = false;
    }
    if (InputSearchCollect.dropDownValue
            .compareTo(InputSearchCollect.items[1]) ==
        0) {
      ManageCollectScreen.indext = 1;
      ManageCollectScreen.isFetch = false;
    }
    if (InputSearchCollect.dropDownValue
            .compareTo(InputSearchCollect.items[2]) ==
        0) {
      ManageCollectScreen.indext = 2;
      ManageCollectScreen.isFetch = false;
    }
    if (InputSearchCollect.dropDownValue
            .compareTo(InputSearchCollect.items[3]) ==
        0) {
      ManageCollectScreen.indext = 3;
      ManageCollectScreen.isFetch = false;
    }
    BlocProvider.of<CostCollectBloc>(context).add(GetCostCollectsEvent());
  }

  searchName(String query) {
    final suggestions = empCostCollectsTmp.where((costCollect) {
      final name = costCollect.nameCategoryCollect.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(
      () {
        empCostCollects = suggestions;
      },
    );
  }
}
