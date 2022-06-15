import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_state.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/category_spend.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/refresh_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/type_spend_card.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import '../../../configs/colors.dart';
import '../../../configs/constants.dart';
import '../../Components/card/drawer_item_card.dart';
import '../../home_screen.dart';

class CategorySpendScreen extends StatefulWidget {
  const CategorySpendScreen({Key? key}) : super(key: key);
  @override
  _CategorySpendScreenState createState() => _CategorySpendScreenState();
}

List<CategorySpend> categorySpends = [];

class _CategorySpendScreenState extends State<CategorySpendScreen> {
  @override
  void initState() {
    BlocProvider.of<CategorySpendBloc>(context).add(GetCategorySpendsEvent());
    // TODO: implement initState
    super.initState();
  }

  final refreshKeyCategory = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(
          child: Text('Danh mục chi'),
        ),
        centerTitle: true,
      ),
      body: RefreshWidget(
        onRefresh: refresh,
        keyRefresh: refreshKeyCategory,
        child: BlocConsumer<CategorySpendBloc, CategorySpendState>(
          buildWhen: (context, state) {
            return state is GetCategorySpendLoadingState ||
                state is GetCategorySpendLoadedState ||
                state is GetCategorySpendErrorState;
          },
          builder: (context, state) {
            if (state is GetCategorySpendLoadingState) {
              LoadingHelper.showLoading(context);
            } else if (state is GetCategorySpendLoadedState) {
              LoadingHelper.hideLoading(context);
              categorySpends = state.categorySpend;
              return categorySpends.isNotEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16,top: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.vertical,
                            itemCount: categorySpends.length,
                            itemBuilder: (context, index) =>
                                TypeSpendCard(categorySpends[index], index),
                          ),
                        ],
                      ),
                    )
                  :  Center(
                      child: Text('Chưa có danh mục chi !',style: AppThemes.commonText,),
                    );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is GetCategorySpendErrorState) {
              LoadingHelper.hideLoading(context);
              FunctionHelper.showSnackBar(context: context, title: state.error);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result =
              await Navigator.pushNamed(context, Constants.addTypeSpendScreen);
          if (result != null) {
            setState(
              () {
                categorySpends.add(result as CategorySpend);
              },
            );
          }
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
    refreshKeyCategory.currentState?.show();
    await Future.delayed(const Duration(microseconds: 400));
    BlocProvider.of<CategorySpendBloc>(context).add(GetCategorySpendsEvent());
  }
}
