
import 'package:equatable/equatable.dart';
abstract class ForgotEvent extends Equatable {
  const ForgotEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordEvent extends ForgotEvent {
  final String email;
  const ForgotPasswordEvent({required this.email});
}