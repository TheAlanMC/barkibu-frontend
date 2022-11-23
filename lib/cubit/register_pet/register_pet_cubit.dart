import 'dart:io';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/services.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'register_pet_state.dart';

class RegisterPetCubit extends Cubit<RegisterPetState> {
  RegisterPetCubit() : super(const RegisterPetState());

  void reset() {
    emit(const RegisterPetState());
  }

  Future<void> registerPet({
    required int breedId,
    required String name,
    required String gender,
    required bool castrated,
    required DateTime bornDate,
    required String photoPath,
    String? chipNumber,
  }) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String response = await RegisterPetService.registerPet(breedId, name, gender, castrated, bornDate, photoPath, chipNumber);
      emit(state.copyWith(status: ScreenStatus.success, result: response));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  // TODO MAYBE:
  // void changeBornDate(String date) {
  //   emit(state.copyWith(bornDate: date));
  // }

  void changeSpecieValue(value) {
    emit(state.copyWith(status: ScreenStatus.initial, specieId: value, breedId: 0));
  }

  void changeBreedValue(value) {
    emit(state.copyWith(status: ScreenStatus.initial, breedId: value));
  }

  void changeImage(String path) {
    emit(state.copyWith(photoPath: path, newPictureFile: File.fromUri(Uri(path: path))));
  }
}
