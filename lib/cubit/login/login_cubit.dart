import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login(String username, String password) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      LoginResponseDto response = await LoginService.login(username, password);
      await Future.delayed(const Duration(seconds: 3));
      if (response.success) {
        emit(state.copyWith(
            loginSuccess: true, status: PageStatus.success, token: response.token, refreshToken: response.refreshToken));
      } else if (!response.success) {
        emit(state.copyWith(loginSuccess: false, status: PageStatus.failure, errorMessage: "Usuario o contraseña incorrectos"));
      }
    } on Exception catch (ex) {
      emit(state.copyWith(
          loginSuccess: false, status: PageStatus.failure, errorMessage: "Error al intentar autenticar al usuario", exception: ex));
    }
  }
}
