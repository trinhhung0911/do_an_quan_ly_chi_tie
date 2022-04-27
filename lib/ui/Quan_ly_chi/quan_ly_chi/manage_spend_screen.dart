import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_event.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/models/cost_spend.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/cost_spend_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/input/input_search.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';

import '../../../bloc/cost_spend_bloc/cost_spend_bloc.dart';
import '../../../bloc/cost_spend_bloc/cost_spend_state.dart';

class ManageSpendScreen extends StatefulWidget {
  const ManageSpendScreen({Key? key}) : super(key: key);
  @override
  _ManageSpendScreenState createState() => _ManageSpendScreenState();
}
List<CategorySpend> categorySpends = [];
List<CostSpend> costSpends = [];
class _ManageSpendScreenState extends State<ManageSpendScreen> {
  @override
  void initState() {
    BlocProvider.of<CostSpendBloc>(context).add(GetCostCategorySpendsEvent());
    BlocProvider.of<CostSpendBloc>(context).add(GetCostSpendsEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Quản lý chi'),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child:  Column(
          children: [
            InputSearch(searchNameEmployee),
            BlocConsumer<CostSpendBloc,CostSpendState>(
              buildWhen: (context, state) {
                return state is GetCostCategorySpendLoadingState ||
                    state is GetCostSpendLoadingState ||
                    state is GetCostCategorySpendLoadedState ||
                    state is GetCostSpendLoadedState ||
                    state is GetCostCategorySpendErrorState||
                    state is GetCostSpendErrorState;
              },
              builder: (context, state) {
                if (state is GetCostCategorySpendLoadingState ||
                    state is GetCostSpendLoadingState
                ) {
                  LoadingHelper.showLoading(context);
                }
                else if (state is GetCostCategorySpendLoadedState) {
                  LoadingHelper.hideLoading(context);
                  categorySpends = state.categorySpend;
                }else if(state is GetCostSpendLoadedState){
                  LoadingHelper.hideLoading(context);
                  costSpends=state.costSpend;
                  return costSpends.isNotEmpty
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
                          itemCount: costSpends.length,
                          itemBuilder: (context, index) => CostSpendCard(costSpends[index], index)
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
                if (state is GetCostCategorySpendErrorState) {
                  LoadingHelper.hideLoading(context);
                  FunctionHelper.showSnackBar(context: context, title: state.error);
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var result = await  Navigator.pushNamed(context, Constants.addSpendScreen);
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
          backgroundColor:AppColors.appColor,
        heroTag: "btn_qlct",
      ),
      drawer:  DrawerItem(email: HomeScreen.email,),
    );
  }
  searchNameEmployee(String query) {}
}
