import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_recovery_state.dart';

class PasswordRecoveryCubit extends Cubit<PasswordRecoveryState> {
  PasswordRecoveryCubit() : super(const PasswordRecoveryState());
  void reset() {
    emit(const PasswordRecoveryState());
  }

  Future<void> sendEmail({required String email}) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await PasswordRecoveryService.sendEmail(email);
      emit(state.copyWith(status: ScreenStatus.success, result: response, email: email));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    }
  }
}
