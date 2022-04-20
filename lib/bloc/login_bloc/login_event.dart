
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginAddEvent extends LoginEvent {
  final String email;
  final String password;
  const LoginAddEvent({required this.email, required this.password});
}