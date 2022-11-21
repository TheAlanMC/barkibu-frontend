part of 'user_veterinarian_cubit.dart';

class UserVeterinarianState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final UserVeterinarianDto? userVeterinarianDto;
  final List<CountryDto>? countries;
  final List<StateDto>? states;
  final List<CityDto>? cities;
  final int? selectedCountry;
  final int? selectedState;
  final int? selectedCity;

  const UserVeterinarianState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.userVeterinarianDto,
    this.countries,
    this.states,
    this.cities,
    this.selectedCountry,
    this.selectedState,
    this.selectedCity,
  });

  UserVeterinarianState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    UserVeterinarianDto? userVeterinarianDto,
    List<CountryDto>? countries,
    List<StateDto>? states,
    List<CityDto>? cities,
    int? selectedCountry,
    int? selectedState,
    int? selectedCity,
  }) {
    return UserVeterinarianState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      userVeterinarianDto: userVeterinarianDto ?? this.userVeterinarianDto,
      countries: countries ?? this.countries,
      states: states ?? this.states,
      cities: cities ?? this.cities,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedState: selectedState ?? this.selectedState,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }

  @override
  List<Object?> get props => [
        status,
        result,
        statusCode,
        errorDetail,
        userVeterinarianDto,
        countries,
        states,
        cities,
      ];
}
