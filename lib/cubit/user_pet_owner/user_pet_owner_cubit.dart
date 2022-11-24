import 'package:barkibu/dto/user_pet_owner_dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'user_pet_owner_state.dart';

class UserPetOwnerCubit extends Cubit<UserPetOwnerState> {
  UserPetOwnerCubit() : super(const UserPetOwnerState());

  void reset() {
    emit(const UserPetOwnerState());
  }

  Future<void> getUserPetOwner() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      UserPetOwnerDto userPetOwnerDto = await UserPetOwnerService.getUserPetOwner();
      emit(state.copyWith(status: ScreenStatus.success, userPetOwnerDto: userPetOwnerDto));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> updateUserPetOwner({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
  }) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await UserPetOwnerService.updateUserPetOwner(firstName, lastName, userName, email);
      emit(state.copyWith(status: ScreenStatus.success, result: response));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }
}
