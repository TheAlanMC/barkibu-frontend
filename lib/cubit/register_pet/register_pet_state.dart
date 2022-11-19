part of 'register_pet_cubit.dart';

class RegisterPetState extends Equatable {
  final ScreenStatus status;
  final bool registerPetSuccess;
  final String? errorMessage;
  final Exception? exception;
  final String? name;
  final String? specie;
  final String? gender;
  final String? castrated;
  final String? bornDate;
  final int? breed;
  final String? lastRabiesVaccineDate;
  final String? lastPolyvalentVaccineDate;
  final String? lastDewormingDate;
  final String? photoPath;

  const RegisterPetState({
    this.status = ScreenStatus.initial,
    this.registerPetSuccess = false,
    this.errorMessage,
    this.exception,
    this.name,
    this.specie = 'Perro',
    this.gender = 'Macho',
    this.castrated,
    this.bornDate,
    this.breed,
    this.lastRabiesVaccineDate,
    this.lastPolyvalentVaccineDate,
    this.lastDewormingDate,
    this.photoPath,
  });

  RegisterPetState copyWith({
    ScreenStatus? status,
    bool? registerPetSuccess,
    String? errorMessage,
    Exception? exception,
    String? name,
    String? specie,
    String? gender,
    String? castrated,
    String? bornDate,
    int? breed,
    String? lastRabiesVaccineDate,
    String? lastPolyvalentVaccineDate,
    String? lastDewormingDate,
    String? photoPath,
  }) {
    return RegisterPetState(
      status: status ?? this.status,
      registerPetSuccess: registerPetSuccess ?? this.registerPetSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
      name: name ?? this.name,
      specie: specie ?? this.specie,
      gender: gender ?? this.gender,
      castrated: castrated ?? this.castrated,
      bornDate: bornDate ?? this.bornDate,
      breed: breed ?? this.breed,
      lastRabiesVaccineDate: lastRabiesVaccineDate ?? this.lastRabiesVaccineDate,
      lastPolyvalentVaccineDate: lastPolyvalentVaccineDate ?? this.lastPolyvalentVaccineDate,
      lastDewormingDate: lastDewormingDate ?? this.lastDewormingDate,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  List<Object?> get props => [
        status,
        registerPetSuccess,
        errorMessage,
        exception,
        name,
        specie,
        gender,
        castrated,
        bornDate,
        breed,
        lastRabiesVaccineDate,
        lastPolyvalentVaccineDate,
        lastDewormingDate,
        photoPath,
      ];
}
