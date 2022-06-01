import 'package:equatable/equatable.dart';
abstract class StatisticalEvent extends Equatable {
  const StatisticalEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


//Get Users event
class GetStatisticalEvent extends StatisticalEvent{}
