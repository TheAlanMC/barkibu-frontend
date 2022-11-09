import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login({required String username, required String password}) async {
    //TODO: three strikes policy for login
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      print('username: $username, password: $password');
      LoginResponseDto response = await LoginService.login(username, password);
      if (response.statusCode == 'SCTY-0000') {
        emit(state.copyWith(status: ScreenStatus.success, loginSuccess: true));
      } else {
        emit(state.copyWith(status: ScreenStatus.failure, errorMessage: response.errorDetail));
      }
      // await Future.delayed(const Duration(seconds: 3));
      // if (response.success) {
      //   emit(state.copyWith(
      //       loginSuccess: true, status: ScreenStatus.success, token: response.token, refreshToken: response.refreshToken));
      // } else if (!response.success) {
      //   emit(state.copyWith(loginSuccess: false, status: ScreenStatus.failure, errorMessage: "Usuario o contraseña incorrectos"));
      // }
      // print(response.result.refreshToken);
    } on Exception catch (ex) {
      emit(state.copyWith(
          loginSuccess: false, status: ScreenStatus.failure, errorMessage: "Error al intentar autenticar al usuario", exception: ex));
    }
  }
}
