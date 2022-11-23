part of 'pet_info_cubit.dart';

class PetInfoState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final List<PetInfoDto>? pets;
  final int? petId;

  const PetInfoState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.pets,
    this.petId,
  });

  PetInfoState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    List<PetInfoDto>? pets,
    int? petId,
  }) {
    return PetInfoState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      pets: pets ?? this.pets,
      petId: petId ?? this.petId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        result,
        statusCode,
        errorDetail,
        pets,
        petId,
      ];
}
