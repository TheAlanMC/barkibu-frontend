import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/barkibu_exception.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login({required String userName, required String password}) async {
    final storage = FlutterSecureStorage();

    emit(state.copyWith(status: ScreenStatus.loading));

    try {
      LoginResponseDto response = await LoginService.login(userName, password);
      await storage.write(key: 'token', value: response.token);
      await storage.write(key: 'refreshToken', value: response.refreshToken);
      emit(state.copyWith(
        status: ScreenStatus.success,
        token: response.token,
        refreshToken: response.refreshToken,
      ));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(
        status: ScreenStatus.failure,
        statusCode: ex.statusCode,
        errorDetail: ex.toString(),
      ));
    }
  }
}
