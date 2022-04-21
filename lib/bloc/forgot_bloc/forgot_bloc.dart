import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/forgot_bloc/forgot_event.dart';
import 'package:quan_ly_chi_tieu/bloc/forgot_bloc/forgot_state.dart';
import 'package:quan_ly_chi_tieu/repositories/forgot_repository.dart';


class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {

  final ForgotRepository forgotRepository;
  ForgotBloc({required this.forgotRepository}) : super(ForgotInitialState());
  @override
  Stream<ForgotState> mapEventToState(ForgotEvent event) async* {
    if (event is ForgotPasswordEvent) {
      yield* _mapForgotPasswordToState(event)  ;
    }
  }
  Stream<ForgotState>  _mapForgotPasswordToState(ForgotPasswordEvent event) async*{
    yield ForgotLoadingState();
    try{
      await forgotRepository.forgotPassword(email:event.email);
      yield ForgotSuccessState();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        yield const ForgotErrorState(
            error: 'Không tìm thấy email đăng nhập');
      } else if (e.code == 'wrong-password') {
        yield const ForgotErrorState(
            error: 'Sai mật khẩu');
      } else if (e.code == "invalid-email") {
        yield const ForgotErrorState(error: 'Sai định dạng email');
      }
      yield const ForgotErrorState(error: 'Không tìm thấy email');
    }

  }
}