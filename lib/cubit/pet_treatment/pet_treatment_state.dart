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
      ];
}
