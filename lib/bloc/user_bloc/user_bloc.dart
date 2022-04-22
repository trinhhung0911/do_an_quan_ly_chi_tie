import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_event.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_state.dart';
import 'package:quan_ly_chi_tieu/repositories/user_repository.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState());
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is CreateUserEvent) {
      yield* _mapCreateUserEventToState(event);
    }
  }
  Stream<UserState> _mapCreateUserEventToState(CreateUserEvent  event) async*{
    yield CreateUserLoadingState();
    try {
      await userRepository.createUser(user: event.users);
      yield CreateUserSuccessState();
    } on FirebaseAuthException catch (e) {
      if(e.code=='email-already-in-use'){
        yield  CreateUserErrorState(error: 'Email đã tồn tại');
      }


    }

  }
}
