
import 'package:equatable/equatable.dart';

abstract class ForgotEvent extends Equatable {
  const ForgotEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//Quên mật khẩu
class ForgotPasswordEvent extends ForgotEvent {
  final String email;
  const ForgotPasswordEvent({required this.email});
}
//Đổi mật khẩu
class UpdatePasswordEvent extends ForgotEvent{
  final String currentPassword;
  final String newPassword;
  const   UpdatePasswordEvent({required this.currentPassword, required this.newPassword});
}