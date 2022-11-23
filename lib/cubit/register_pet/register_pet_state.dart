part of 'register_pet_cubit.dart';

class RegisterPetState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final File? newPictureFile;
  final String? photoPath;
  final List<SpecieDto>? species;
  final List<BreedDto>? breeds;
  final int specieId;
  final int breedId;

  const RegisterPetState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.newPictureFile,
    this.photoPath,
    this.species,
    this.breeds,
    this.specieId = 0,
    this.breedId = 0,
  });

  RegisterPetState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    File? newPictureFile,
    String? photoPath,
    List<SpecieDto>? species,
    List<BreedDto>? breeds,
    int? specieId,
    int? breedId,
  }) {
    return RegisterPetState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      newPictureFile: newPictureFile ?? this.newPictureFile,
      photoPath: photoPath ?? this.photoPath,
      species: species ?? this.species,
      breeds: breeds ?? this.breeds,
      specieId: specieId ?? this.specieId,
      breedId: breedId ?? this.breedId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        result,
        statusCode,
        errorDetail,
        newPictureFile,
        photoPath,
        species,
        breeds,
        specieId,
        breedId,
      ];
}
