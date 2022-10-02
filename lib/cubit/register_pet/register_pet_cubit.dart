import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_pet_state.dart';

class RegisterPetCubit extends Cubit<RegisterPetState> {
  RegisterPetCubit() : super(const RegisterPetState());

  Future<void> registerPet({
    required String name,
    String? specie,
    String? gender,
    String? castrated,
    String? bornDate,
    int? breed,
    String? lastRabiesVaccineDate,
    String? lastPolyvalentVaccineDate,
    String? lastDewormingDate,
    String? photoPath,
  }) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      RegisterPetResponseDto response = await RegisterPetService.registerPet(name);
      await Future.delayed(const Duration(seconds: 3));
      if (response.success) {
        emit(state.copyWith(registerPetSuccess: true, status: ScreenStatus.success));
      } else if (!response.success) {
        emit(state.copyWith(registerPetSuccess: false, status: ScreenStatus.failure, errorMessage: "Campos incompletos"));
      }
    } on Exception catch (ex) {
      emit(state.copyWith(
          registerPetSuccess: false,
          status: ScreenStatus.failure,
          errorMessage: "Error al intentar registrar la mascota",
          exception: ex));
    }
  }

  void changeSpecie(String? value) {
    emit(state.copyWith(specie: value));
  }

  void changeGender(String? value) {
    emit(state.copyWith(gender: value));
  }

  void changeCastrated(String? value) {
    emit(state.copyWith(castrated: value));
  }

  void changeBornDate(String date) {
    emit(state.copyWith(bornDate: date));
  }

  void changeBreed(int value) {
    emit(state.copyWith(breed: value));
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void changeLastRabiesVaccineDate(String date) {
    emit(state.copyWith(lastRabiesVaccineDate: date));
  }

  void changeLastPolyvalentVaccineDate(String date) {
    emit(state.copyWith(lastPolyvalentVaccineDate: date));
  }

  void changeLastDewormingDate(String date) {
    emit(state.copyWith(lastDewormingDate: date));
  }
}
