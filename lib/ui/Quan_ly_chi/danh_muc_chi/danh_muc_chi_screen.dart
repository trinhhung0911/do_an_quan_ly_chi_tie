import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_event.dart';
import 'package:quan_ly_chi_tieu/bloc/category_spend_bloc/category_spend_state.dart';
import 'package:quan_ly_chi_tieu/configs/app_data.dart';
import 'package:quan_ly_chi_tieu/models/categor_spend.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/loai_chi_card.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import '../../../configs/colors.dart';
import '../../../configs/constants.dart';
import '../../Components/home_components/drawer_item_card.dart';
import '../../home_screen.dart';

class DanhMucChiScreen extends StatefulWidget {
  const DanhMucChiScreen({Key? key}) : super(key: key);
  @override
  _DanhMucChiScreenState createState() => _DanhMucChiScreenState();
}
List<CategorySpend> categorySpends = [];
class _DanhMucChiScreenState extends State<DanhMucChiScreen> {
  @override
  void initState() {
    BlocProvider.of<CategorySpendBloc>(context).add(GetCategorySpendsEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Danh mục chi'),),
        centerTitle: true,
      ),
      body:  BlocConsumer<CategorySpendBloc, CategorySpendState>(
        buildWhen: (context, state) {
          return state is GetCategorySpendLoadingState ||
              state is GetCategorySpendLoadedState ||
              state is GetCategorySpendLoadedState;
        },
        builder: (context, state) {
          if (state is GetCategorySpendLoadingState) {
            LoadingHelper.showLoading(context);
          }
          else if (state is GetCategorySpendLoadedState) {
            LoadingHelper.hideLoading(context);
            categorySpends = state.categorySpend;
            return categorySpends.isNotEmpty
                ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categorySpends.length,
                      itemBuilder: (context, index) =>TypeSpendCard(categorySpends[index],index)
                  ),
                ],
              ),
            ) :
               const Center(
                child: Text('Chưa có danh mục chi !'),
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is GetCategorySpendErrorState) {
            LoadingHelper.hideLoading(context);
            FunctionHelper.showSnackBar(context: context, title:state.error);
          }
        },

      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var result=await Navigator.pushNamed(context, Constants.addTypeSpendScreen);
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
          backgroundColor:AppColors.appColor,
        heroTag: "btn_1",
      ),
      drawer:  DrawerItem(email: HomeScreen.email,),
    );
  }
}
