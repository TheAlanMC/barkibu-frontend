import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  final storage = const FlutterSecureStorage();

  Future<void> login({required String userName, required String password}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      LoginResponseDto response = await LoginService.login(userName, password);
      await storage.write(key: 'token', value: response.token);
      await storage.write(key: 'refreshToken', value: response.refreshToken);
      emit(state.copyWith(status: ScreenStatus.success, token: response.token, refreshToken: response.refreshToken));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    }
  }

  Future<void> getGroups() async {
    try {
      List<String> groups = await LoginService.getGroups(state.token!);
      emit(state.copyWith(groups: groups));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    }
  }

  Future<void> loadToken() async {
    String token = await storage.read(key: 'token') ?? '';
    String refreshToken = await storage.read(key: 'refreshToken') ?? '';
    emit(state.copyWith(status: ScreenStatus.success, token: token, refreshToken: refreshToken));
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');
    emit(state.copyWith(status: ScreenStatus.success, token: '', refreshToken: ''));
  }

// Metodo utilizado para omitir el login si ya se ha iniciado sesión
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
