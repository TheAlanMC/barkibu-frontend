import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit() : super(const RegisterUserState());

  void reset() {
    emit(const RegisterUserState());
  }

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await RegisterUserService.registerUser(firstName, lastName, userName, email, password, confirmPassword);
      emit(state.copyWith(status: ScreenStatus.success, result: response));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    }
  }

  void passwordStrength(String password) {
    emit(state.copyWith(password: password));
  }
}
