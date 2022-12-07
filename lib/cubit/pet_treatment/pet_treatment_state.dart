part of 'pet_treatment_cubit.dart';

class PetTreatmentState extends Equatable {
  final ScreenStatus status;
  final String? result;
  final String? statusCode;
  final String? errorDetail;
  final String? treatmentLastDate;
  final String? treatmentNextDate;
  final int treatmentId;
  final List<TreatmentDto>? treatments;
  final List<PetTreatmentDto>? petTreatments;
  final PetTreatmentDto? petTreatment;
  final String? treatmentDescription;
  final int petTreatmentId;

  const PetTreatmentState({
    this.status = ScreenStatus.initial,
    this.result,
    this.statusCode,
    this.errorDetail,
    this.treatmentLastDate,
    this.treatmentNextDate,
    this.treatmentId = 0,
    this.treatments,
    this.petTreatments,
    this.petTreatment,
    this.treatmentDescription,
    this.petTreatmentId = 0,
  });

  PetTreatmentState copyWith({
    ScreenStatus? status,
    String? result,
    String? statusCode,
    String? errorDetail,
    String? treatmentLastDate,
    String? treatmentNextDate,
    int? treatmentId,
    List<TreatmentDto>? treatments,
    List<PetTreatmentDto>? petTreatments,
    PetTreatmentDto? petTreatment,
    String? treatmentDescription,
    int? petTreatmentId,
  }) {
    return PetTreatmentState(
      status: status ?? this.status,
      result: result ?? this.result,
      statusCode: statusCode ?? this.statusCode,
      errorDetail: errorDetail ?? this.errorDetail,
      treatmentLastDate: treatmentLastDate ?? this.treatmentLastDate,
      treatmentNextDate: treatmentNextDate ?? this.treatmentNextDate,
      treatmentId: treatmentId ?? this.treatmentId,
      treatments: treatments ?? this.treatments,
      petTreatments: petTreatments ?? this.petTreatments,
      petTreatment: petTreatment ?? this.petTreatment,
      treatmentDescription: treatmentDescription ?? this.treatmentDescription,
      petTreatmentId: petTreatmentId ?? this.petTreatmentId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        result,
        statusCode,
        errorDetail,
        treatmentLastDate,
        treatmentNextDate,
        treatmentId,
        treatments,
        petTreatments,
        petTreatment,
        treatmentDescription,
        petTreatmentId,
      ];
}
