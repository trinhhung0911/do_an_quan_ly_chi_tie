import 'package:equatable/equatable.dart';

//LoginState
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
// Trạng thái khởi tạo
class LoginInitialState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {}
class LoginErrorState extends LoginState {
  final String error;
  const LoginErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}