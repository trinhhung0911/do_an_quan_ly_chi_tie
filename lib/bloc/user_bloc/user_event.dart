import 'package:equatable/equatable.dart';
import 'package:quan_ly_chi_tieu/models/users.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CreateUserEvent extends UserEvent {
  final Users users;
  const CreateUserEvent({required this.users});
}
