import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_event.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_collect_bloc/cost_collect_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_collect.dart';
import 'package:quan_ly_chi_tieu/models/cost_collect.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/refresh_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/input/input_search.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

class ManageCollectScreen extends StatefulWidget {
  const ManageCollectScreen({Key? key}) : super(key: key);
  @override
  _ManageCollectScreenState createState() => _ManageCollectScreenState();
}

List<CategoryCollect> categoryCollects=[];
List<CostCollect> costCollect=[];
final  refreshKeyManageCollect= GlobalKey<RefreshIndicatorState>();

class _ManageCollectScreenState extends State<ManageCollectScreen> {
  @override
  @override
  void initState() {
    BlocProvider.of<CostCollectBloc>(context).add(GetCostCategoryCollectsEvent());
   // BlocProvider.of<CostCollectBloc>(context).add(GetCostCollectsEvent());
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
      body:  RefreshWidget(
        onRefresh:refresh,
        keyRefresh: refreshKeyManageCollect,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child:  Column(
            children: [
               const InputSearch(searchNameEmployee),
              BlocConsumer<CostCollectBloc,CostCollectState>(
                buildWhen: (context, state) {
                  return state is GetCostCategoryCollectLoadingState ||
                      state is GetCostCollectLoadingState ||
                      state is GetCostCategoryCollectLoadedState ||
                      state is GetCostCollectLoadedState ||
                      state is GetCostCategoryCollectErrorState||
                      state is GetCostCollectErrorState;
                },
                builder: (context, state) {
                  if (state is GetCostCategoryCollectLoadingState ||
                      state is GetCostCollectLoadingState) {
                    LoadingHelper.showLoading(context);
                  }
                  else if (state is GetCostCategoryCollectLoadedState) {
                    LoadingHelper.hideLoading(context);
                    categoryCollects = state.categoryCollect;
                    print('Huwng');
                    print(state.categoryCollect.length);
                  }
                  else if(state is GetCostCollectLoadedState){
                    LoadingHelper.hideLoading(context);
                    costCollect=state.costCollect;
                    return costCollect.isNotEmpty
                        ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          ListView.builder(
                              padding: const EdgeInsets.only(left: 24, right: 24),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: costCollect.length,
                              itemBuilder: (context, index) => Text('ds')
                          ),
                        ],
                      ),
                    )
                        : const Center(
                      child: Text('Chưa có khoản chi nào!'),
                    );
                  }
                  return Container();
                },
                listener: (context, state) {
                  if (state is GetCostCategoryCollectErrorState) {
                    LoadingHelper.hideLoading(context);
                    FunctionHelper.showSnackBar(context: context, title: state.error);
                  }
                  else if(state is GetCostCollectErrorState){
                    LoadingHelper.hideLoading(context);
                    FunctionHelper.showSnackBar(context: context, title: state.error);
                  }
                },
              )

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, Constants.addCostCollectScreen);
          print(categoryCollects.length);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.appColor,
        heroTag: "btn_1",
      ),
      drawer: DrawerItem(
        email: HomeScreen.email,
      ),
    );
  }
  Future<void> refresh() async {
    refreshKeyManageCollect.currentState?.show();
    await Future.delayed(const Duration(microseconds: 400));
    BlocProvider.of<CostCollectBloc>(context).add(GetCostCollectsEvent());
  }
}
searchNameEmployee(String query) {}

