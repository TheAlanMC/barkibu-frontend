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
  final File? newPictureFile;
  final String? photoPath;
  final int? countryId;
  final int? stateId;
  final int cityId;

  const UserVeterinarianState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.userVeterinarianDto,
    this.countries,
    this.states,
    this.cities,
    this.newPictureFile,
    this.photoPath,
    this.countryId,
    this.stateId,
    this.cityId = 0,
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
    File? newPictureFile,
    String? photoPath,
    int? countryId,
    int? stateId,
    int? cityId,
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
      newPictureFile: newPictureFile ?? this.newPictureFile,
      photoPath: photoPath ?? this.photoPath,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
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
        newPictureFile,
        photoPath,
        countryId,
        stateId,
        cityId,
      ];
}
