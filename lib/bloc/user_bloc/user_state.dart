import 'package:equatable/equatable.dart';

//LoginState
abstract class UserState extends Equatable {
  const UserState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
// Trạng thái khởi tạo
class UserInitialState extends UserState {}
class CreateUserLoadingState extends UserState {}
class CreateUserSuccessState extends UserState {}
class CreateUserErrorState extends UserState {
   String error;
  CreateUserErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}