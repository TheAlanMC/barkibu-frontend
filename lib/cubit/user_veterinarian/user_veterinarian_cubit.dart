import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/services/country_state_city_service.dart';
import 'package:barkibu/services/user_veterinarian_service.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'user_veterinarian_state.dart';

class UserVeterinarianCubit extends Cubit<UserVeterinarianState> {
  UserVeterinarianCubit() : super(const UserVeterinarianState());

  Future<void> getUserVeterinarian() async {
    emit(state.copyWith(status: ScreenStatus.loading));
    try {
      UserVeterinarianDto userVeterinarianDto = await UserVeterinarianService.getUserVeterinarian();
      List<CountryDto> countries = await CountryStateCityService.getCountries();
      List<StateDto> states = await CountryStateCityService.getStates();
      List<CityDto> cities = await CountryStateCityService.getCities();
      emit(state.copyWith(
        status: ScreenStatus.success,
        userVeterinarianDto: userVeterinarianDto,
        countries: countries,
        states: states,
        cities: cities,
      ));
    } on BarkibuException catch (ex) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: ex.statusCode, errorDetail: ex.toString()));
    } on ClientException catch (_) {
      emit(state.copyWith(status: ScreenStatus.failure, statusCode: '', errorDetail: 'Error de conexión'));
    }
  }

  void changeCountryValue(value) {
    emit(state.copyWith(
      status: ScreenStatus.initial,
      userVeterinarianDto: state.userVeterinarianDto!.copyWith(countryId: value, stateId: 0, cityId: 0),
    ));
  }

  void changeStateValue(value) {
    emit(state.copyWith(status: ScreenStatus.initial, userVeterinarianDto: state.userVeterinarianDto!.copyWith(stateId: value, cityId: 0)));
  }

  void changeCityValue(value) {
    emit(state.copyWith(status: ScreenStatus.initial, userVeterinarianDto: state.userVeterinarianDto!.copyWith(cityId: value)));
  }
}