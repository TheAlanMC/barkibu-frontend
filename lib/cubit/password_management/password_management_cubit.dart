import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'password_management_state.dart';

class PasswordManagementCubit extends Cubit<PasswordManagementState> {
  PasswordManagementCubit() : super(const PasswordManagementState());

  void reset() {
    emit(const PasswordManagementState());
  }

  Future<void> sendEmail({required String email}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PasswordManagementService.sendEmail(email);
      emit(state.copyWith(status: ScreenStatus.success, result: response, email: email));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> sendCode({required String secretCode}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PasswordManagementService.sendCode(state.email!, secretCode);
      emit(state.copyWith(status: ScreenStatus.success, result: response, secretCode: secretCode));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> updatePassword({required String password, required String confirmPassword}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PasswordManagementService.updatePassword(state.email!, state.secretCode!, password, confirmPassword);
      emit(state.copyWith(status: ScreenStatus.success, result: response, password: password));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> changePassword({required String currentPassword, required String newPassword, required String confirmNewPassword}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PasswordManagementService.changePassword(currentPassword, newPassword, confirmNewPassword);
      emit(state.copyWith(status: ScreenStatus.success, result: response));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  void passwordStrength(String password) {
    emit(state.copyWith(status: ScreenStatus.initial, password: password));
  }
}
