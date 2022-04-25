import 'package:equatable/equatable.dart';

//LoginState
abstract class ForgotState extends Equatable {
  const ForgotState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
// Trạng thái khởi tạo
class ForgotInitialState extends ForgotState {}
//Quên mật khẩu
class ForgotLoadingState extends ForgotState {}
class ForgotSuccessState extends ForgotState {}
class ForgotErrorState extends ForgotState {
  final String error;
  const ForgotErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
// Đổi mật khẩu
class UpdatePasswordLoadingState extends ForgotState{}
class UpdatePasswordSuccessState extends ForgotState{}
class UpdatePasswordErrorState extends ForgotState {
  final String error;
  const UpdatePasswordErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}