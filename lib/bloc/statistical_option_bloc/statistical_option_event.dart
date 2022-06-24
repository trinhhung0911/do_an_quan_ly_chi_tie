import 'package:equatable/equatable.dart';

abstract class StatisticalOptionEvent extends Equatable {
  const StatisticalOptionEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetStatisticalOptionEvent extends StatisticalOptionEvent {
  int day;
  int moth;
  int year;
  GetStatisticalOptionEvent({required this.day, required this.moth, required this.year});
}
