import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'password_recovery_state.dart';

class PasswordRecoveryCubit extends Cubit<PasswordRecoveryState> {
  PasswordRecoveryCubit() : super(const PasswordRecoveryState());

  Future<void> sendEmail({required String email}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PasswordRecoveryService.sendEmail(email);
      emit(state.copyWith(status: ScreenStatus.success, result: response, email: email));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Erorr de conexión'));
    }
  }

  Future<void> sendCode({required String secretCode}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PasswordRecoveryService.sendCode(state.email!, secretCode);
      emit(state.copyWith(status: ScreenStatus.success, result: response, secretCode: secretCode));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Erorr de conexión'));
    }
  }

  Future<void> updatePassword({required String password, required String confirmPassword}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PasswordRecoveryService.updatePassword(state.email!, state.secretCode!, password, confirmPassword);
      emit(state.copyWith(status: ScreenStatus.success, result: response, password: password));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Erorr de conexión'));
    }
  }

  void passwordStrength(String password) {
    emit(state.copyWith(status: ScreenStatus.initial, password: password));
  }
}
