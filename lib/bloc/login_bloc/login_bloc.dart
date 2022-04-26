import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/login_bloc/login_event.dart';
import 'package:quan_ly_chi_tieu/bloc/login_bloc/login_state.dart';
import 'package:quan_ly_chi_tieu/repositories/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitialState());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginAddEvent) {
      yield* _mapLoginAddEventToState(event);
    }
  }
  Stream<LoginState> _mapLoginAddEventToState(LoginAddEvent  event) async*{
    yield LoginLoadingState();
    try {
      await loginRepository.loginWithEmail(
        email: event.email,password: event.password);
      yield LoginSuccessState();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        yield const LoginErrorState(
            error: 'Không tìm thấy email đăng nhập');
      } else if (e.code == 'wrong-password') {
        yield const LoginErrorState(
            error: 'Sai mật khẩu');
      } else if (e.code == "invalid-email") {
        yield const LoginErrorState(error: 'Sai định dạng email');
      } else if(e.code=='network-request-failed'){
        yield  const LoginErrorState(error: 'Kiểm tra lại kết nối internet của bạn !');
      }

    }

  }
}
