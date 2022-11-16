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

  void reset() {
    emit(const LoginState());
  }

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

  Future<List<String>> getGroups() async {
    return await LoginService.getGroups(state.token!);
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<void> loadToken() async {
    String token = await storage.read(key: 'token') ?? '';
    String refreshToken = await storage.read(key: 'refreshToken') ?? '';
    emit(state.copyWith(status: ScreenStatus.success, token: token, refreshToken: refreshToken));
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');
  }
}
