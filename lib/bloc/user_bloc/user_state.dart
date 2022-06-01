import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/get_user.dart';


//LoginState
abstract class UserState extends Equatable {
  const UserState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
// Trạng thái khởi tạo
class UserInitialState extends UserState {}
//Create tài khoản
class CreateUserLoadingState extends UserState {}
class CreateUserSuccessState extends UserState {}
class CreateUserErrorState extends UserState {
   String error;
  CreateUserErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
//Get User
class GetUserLoadingState extends UserState {}
class GetUserLoadedState extends UserState {
  List<GetUser> getUser;
  GetUserLoadedState({required this.getUser});
}
class GetUserErrorState extends UserState {
  final String error;
  const GetUserErrorState({required this.error});
}
