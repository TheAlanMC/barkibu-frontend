import 'dart:io';

import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/country_state_city_service.dart';
import 'package:barkibu/services/image_upload_service.dart';
import 'package:barkibu/services/user_veterinarian_service.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'user_veterinarian_state.dart';

class UserVeterinarianCubit extends Cubit<UserVeterinarianState> {
  UserVeterinarianCubit() : super(const UserVeterinarianState());

  void reset() {
    emit(const UserVeterinarianState());
  }

  Future<void> getUserVeterinarian() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      UserVeterinarianDto userVeterinarianDto = await UserVeterinarianService.getUserVeterinarian();
      userVeterinarianDto.validatePhotoPath();
      List<CountryDto> countries = await CountryStateCityService.getCountries();
      List<StateDto> states = await CountryStateCityService.getStates();
      List<CityDto> cities = await CountryStateCityService.getCities();
      emit(state.copyWith(
          status: ScreenStatus.success,
          userVeterinarianDto: userVeterinarianDto,
          countries: countries,
          states: states,
          cities: cities,
          photoPath: userVeterinarianDto.photoPath,
          countryId: userVeterinarianDto.countryId,
          cityId: userVeterinarianDto.cityId,
          stateId: userVeterinarianDto.stateId));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  Future<void> updateUserVeterinarian({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String description,
  }) async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      String? newPhotoPath = await ImageUploadService.uploadImage(state.newPictureFile);
      String? uploadPhotoPath = newPhotoPath ?? state.photoPath;
      String response =
          await UserVeterinarianService.updateUserVeterinarian(firstName, lastName, state.cityId, userName, email, description, uploadPhotoPath);
      emit(state.copyWith(status: ScreenStatus.success, result: response));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  void changeCountryValue(value) {
    emit(
      state.copyWith(status: ScreenStatus.initial, countryId: value, stateId: 0, cityId: 0),
    );
  }

  void changeStateValue(value) {
    emit(state.copyWith(status: ScreenStatus.initial, stateId: value, cityId: 0));
  }

  void changeCityValue(value) {
    emit(state.copyWith(status: ScreenStatus.initial, cityId: value));
  }

  void changeImage(String path) {
    emit(state.copyWith(status: ScreenStatus.initial, newPictureFile: File.fromUri(Uri(path: path)), photoPath: path));
  }
}
