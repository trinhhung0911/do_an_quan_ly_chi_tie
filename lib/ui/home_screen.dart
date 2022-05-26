import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_event.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/constants.dart';
import 'package:quan_ly_chi_tieu/models/get_user.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';
import 'package:quan_ly_chi_tieu/ui/Components/home_components/chart_collection.dart';
import 'package:quan_ly_chi_tieu/ui/components/card/refresh_card.dart';
import 'package:quan_ly_chi_tieu/ui/components/home_components/money_home.dart';
import 'package:quan_ly_chi_tieu/ui/components/home_components/status_collection.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import 'Components/card/drawer_item_card.dart';
class HomeScreen extends StatefulWidget {
  final dynamic arg;
  static String email='';
  const HomeScreen({Key? key, this.arg}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final refreshKeyUsers = GlobalKey<RefreshIndicatorState>();
  late List<GetUser> getUser;
  @override
  void initState() {
   HomeScreen.email=widget.arg;
   BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title: const Center(child: Text('Trang chủ'),),
        centerTitle: true,
      ),
      body:RefreshWidget(
        onRefresh: refresh,
        keyRefresh: refreshKeyUsers,
        child:  SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocConsumer<UserBloc,UserState>(
              buildWhen: (context, state) {
                return state is GetUserLoadingState ||
                     state is GetUserLoadedState ||
                     state is GetUserErrorState;
              },
              builder: (context,state){
                if (state is GetUserLoadingState) {
                  LoadingHelper.showLoading(context);
                  print('Đang load');
                }else if (state is GetUserLoadedState ){
                  print('Thành công');
                  LoadingHelper.hideLoading(context);
                 getUser=state.getUser;
                  return  Column(
                    children:  <Widget>[
                      MoneyHome(sumMoney:getUser.first.user!.sumMoney!),
                      const SizedBox(height: 5,),
                      StatusCollection(sumSpend: getUser.first.sumAllSpend!),
                      const SizedBox(height: 10,),
                      const ChartCollection(),
                    ],
                  );
                }
                return Container();
              },
            listener: (context, state) {
              if (state is GetUserErrorState) {
                print('Lỗi');
                LoadingHelper.hideLoading(context);
                FunctionHelper.showSnackBar(
                    context: context, title: state.error);
              }
            },
          ),


        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.pushNamed(context, Constants.addSpendScreen);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor:AppColors.appColor),
      drawer:  DrawerItem(email: widget.arg,),
    );
  }
  Future<void> refresh() async {
    refreshKeyUsers.currentState?.show();
    await Future.delayed(const Duration(microseconds: 400));
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
  }
}
