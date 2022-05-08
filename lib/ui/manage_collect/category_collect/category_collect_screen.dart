import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_collect_bloc/category_collect_event.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';

import 'package:quan_ly_chi_tieu/ui/Components/card/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/type_collect_card.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import '../../../bloc/category_collect_bloc/category_collect_state.dart';
import '../../Components/card/refresh_card.dart';
import 'package:quan_ly_chi_tieu/models/category_Collect.dart';
class CategoryCollectScreen extends StatefulWidget {
  const CategoryCollectScreen({Key? key}) : super(key: key);
  @override
  _CategoryCollectScreenState createState() => _CategoryCollectScreenState();
}
final refreshKeyCategory = GlobalKey<RefreshIndicatorState>();

List<CategoryCollect> categoryCollects=[];

class _CategoryCollectScreenState extends State<CategoryCollectScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryCollectBloc>(context).add(GetCategoryCollectsEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(
        child: Text('Danh mục thu'),
    ),
    centerTitle: true,
    ),
      body: RefreshWidget(
        onRefresh: refresh,
        keyRefresh: refreshKeyCategory,
        child: BlocConsumer<CategoryCollectBloc, CategoryCollectState>(
          buildWhen: (context, state) {
            return state is GetCategoryCollectLoadingState ||
                state is GetCategoryCollectLoadedState ||
                state is GetCategoryCollectErrorState;
          },
          builder: (context, state) {
            if (state is GetCategoryCollectLoadingState) {
              LoadingHelper.showLoading(context);
            } else if (state is GetCategoryCollectLoadedState) {
              LoadingHelper.hideLoading(context);
              categoryCollects=state.categoryCollect;
              return categoryCollects.isNotEmpty
                  ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categoryCollects.length,
                      itemBuilder: (context, index) =>TypeCollectCard(categoryCollects[index],index),
                    ),
                  ],
                ),
              ) : Center(child: Text('Chưa có danh mục thu !',style: AppThemes.commonText,),
              );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is GetCategoryCollectErrorState) {
              LoadingHelper.hideLoading(context);
              FunctionHelper.showSnackBar(context: context, title: state.error);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, Constants.addCategoryCollectScreen);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.appColor,
        heroTag: "btn_2",
      ),
      drawer: DrawerItem(
        email: HomeScreen.email,
      ),
    );
  }
  Future<void> refresh() async {
    refreshKeyCategory.currentState?.show();
    await Future.delayed(const Duration(microseconds: 400));
    BlocProvider.of<CategoryCollectBloc>(context).add(GetCategoryCollectsEvent());
  }
}
