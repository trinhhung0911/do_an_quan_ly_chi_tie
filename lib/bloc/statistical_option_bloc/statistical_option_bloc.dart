import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_option_bloc/statistical_option_event.dart';
import 'package:quan_ly_chi_tieu/bloc/statistical_option_bloc/statistical_option_state.dart';
import 'package:quan_ly_chi_tieu/models/statistical_option.dart';
import 'package:quan_ly_chi_tieu/repositories/statistical_option_repository.dart';

class StatisticalOptionBloc extends Bloc<StatisticalOptionEvent, StatisticalOptionState> {
  final StatisticalOptionRepository statisticalRepository;
  StatisticalOptionBloc({required this.statisticalRepository})
      : super(StatisticalInitialOptionState());
  @override
  Stream<StatisticalOptionState> mapEventToState(StatisticalOptionEvent event) async* {
    if (event is GetStatisticalOptionEvent) {
      yield* _mapGetStatisticalOptinToState(event);
    }
  }

  Stream<StatisticalOptionState> _mapGetStatisticalOptinToState(GetStatisticalOptionEvent event) async*{
    yield GetStatisticalOptionLoadingState();
    try {
      final StatisticalOption statisticalOption= await statisticalRepository.getStatisticalRepository(day: event.day, moth: event.moth, year: event.year);
      yield GetStatisticalOptionLoadedState(statisticalOption: statisticalOption);
    }on FirebaseAuthException catch (e) {
      yield  GetStatisticalOptionErrorState(error: 'Lỗi');
    }
  }

}