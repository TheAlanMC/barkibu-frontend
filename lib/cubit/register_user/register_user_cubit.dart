import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit() : super(const RegisterUserState());

//TODO: all fields are required
  Future<void> registerUser({
    String? name,
    String? lastName,
    required String userName,
    String? email,
    required String password,
    String? confirmPassword,
  }) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      RegisterUserResponseDto response = await RegisterUserService.registerUser(userName, password);
      await Future.delayed(const Duration(seconds: 3));
      if (response.success) {
        emit(state.copyWith(registerUserSuccess: true, status: ScreenStatus.success));
      } else if (!response.success) {
        emit(state.copyWith(registerUserSuccess: false, status: ScreenStatus.failure, errorMessage: "Usuario existente"));
      }
    } on Exception catch (ex) {
      emit(state.copyWith(
          registerUserSuccess: false,
          status: ScreenStatus.failure,
          errorMessage: "Error al intentar autenticar al usuario",
          exception: ex));
    }
  }

  void passwordStrength(String password) {
    emit(state.copyWith(password: password));
  }
}
