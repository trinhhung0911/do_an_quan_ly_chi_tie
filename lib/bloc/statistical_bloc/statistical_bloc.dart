


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_bloc/statistical_event.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_bloc/statistical_state.dart';
import 'package:quan_ly_chi_tieu/models/get_statistical.dart';
import 'package:quan_ly_chi_tieu/repositories/statistical_repository.dart';



class StatisticalBloc extends Bloc<StatisticalEvent, StatisticalState> {
  final StatisticalRepository statisticalRepository;
  StatisticalBloc({required this.statisticalRepository}) : super(StatisticalInitialState());
  @override
  Stream<StatisticalState> mapEventToState(StatisticalEvent event) async* {
     if(event is GetStatisticalEvent){
      yield* _mapGetStatisticalEventToState(event);
    }

  }

  Stream<StatisticalState> _mapGetStatisticalEventToState(GetStatisticalEvent event) async*{
    yield GetStatisticalLoadingState();
    try {
      GetStatistical getStatistical = await statisticalRepository.getStatistical();
      yield GetStatisticalLoadedState(getStatistical: getStatistical);
    }on FirebaseAuthException catch (e) {
      yield const GetStatisticalErrorState(error: 'Lỗi');
    }
  }





}
