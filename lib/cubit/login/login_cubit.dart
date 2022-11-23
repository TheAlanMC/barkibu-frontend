import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void reset() {
    emit(const LoginState());
  }

  Future<void> login({required String userName, required String password}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      LoginResponseDto response = await LoginService.login(userName, PasswordUtil.sha256Password(password));
      await TokenSecureStorage.saveToken(response.token, response.refreshToken);
      List<String> groups = await LoginService.getGroups();
      emit(state.copyWith(status: ScreenStatus.success, token: response.token, refreshToken: response.refreshToken, groups: groups));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }
}
