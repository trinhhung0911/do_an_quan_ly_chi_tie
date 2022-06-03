import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_bloc/statistical_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_bloc/statistical_event.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_bloc/statistical_state.dart';
import 'package:quan_ly_chi_tieu/configs/colors.dart';
import 'package:quan_ly_chi_tieu/configs/themes.dart';
import 'package:quan_ly_chi_tieu/models/get_statistical.dart';
import 'package:quan_ly_chi_tieu/ui/Components/card/drawer_item_card.dart';
import 'package:quan_ly_chi_tieu/ui/components/card/refresh_card.dart';
import 'package:quan_ly_chi_tieu/ui/home_screen.dart';
import 'package:quan_ly_chi_tieu/ui/statistical/statistical_day/statistical_day_screen.dart';
import 'package:quan_ly_chi_tieu/ui/statistical/statistical_moth/statistical_moth_screen.dart';
import 'package:quan_ly_chi_tieu/utils/function_helper.dart';
import 'package:quan_ly_chi_tieu/utils/loading_helper.dart';
import 'statistical_option/statistical_option_screen.dart';
import 'statistical_year/statistical_year_screen.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({Key? key}) : super(key: key);
  @override
  _StatisticalScreenState createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen> {
  final refreshKeyUsers = GlobalKey<RefreshIndicatorState>();
  late GetStatistical getStatistical;
  @override
  void initState() {
    BlocProvider.of<StatisticalBloc>(context).add(GetStatisticalEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        title: const Text('Thống kê'),
        centerTitle: true,
        backgroundColor: AppColors.appColor,
      ),
      body: RefreshWidget(
        onRefresh: refresh,
        keyRefresh: refreshKeyUsers,
        child: BlocConsumer<StatisticalBloc, StatisticalState>(
          buildWhen: (context, state) {
            return state is GetStatisticalLoadingState ||
                state is GetStatisticalLoadedState ||
                state is GetStatisticalErrorState;
          },
          builder: (context, state) {
            if (state is GetStatisticalLoadingState) {
              LoadingHelper.showLoading(context);
            } else if (state is GetStatisticalLoadedState) {
              LoadingHelper.hideLoading(context);
              getStatistical = state.getStatistical;
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Text(
                            'Ngày này',
                            style: AppThemes.commonText,
                          ),
                          Text(
                            'Tháng này',
                            style: AppThemes.commonText,
                          ),
                          Text(
                            'Năm này',
                            style: AppThemes.commonText,
                          ),
                          Text(
                            'Tùy chọn',
                            style: AppThemes.commonText,
                          )
                        ],
                        indicatorWeight: 1,
                        indicatorColor: AppColors.appColor,
                        labelColor: Colors.white,
                        isScrollable: true,
                      ),
                       Expanded(
                        child: TabBarView(
                          children: [
                            StatisticalDayScreen(getStatistical: getStatistical,),
                            StatisticalMothScreen(getStatistical: getStatistical,),
                            StatisticalYearScreen(getStatistical: getStatistical,),
                            StatisticalOptionScreen(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is GetStatisticalErrorState) {
              LoadingHelper.hideLoading(context);
              FunctionHelper.showSnackBar(context: context, title: state.error);
            }
          },
        ),
      ),
      drawer: DrawerItem(
        email: HomeScreen.email,
      ),
    );
  }

  Future<void> refresh() async {
    refreshKeyUsers.currentState?.show();
    await Future.delayed(
      const Duration(microseconds: 400),
    );
    BlocProvider.of<StatisticalBloc>(context).add(GetStatisticalEvent());
  }
}
