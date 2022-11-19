import 'dart:convert';

class PetTreatmentDto {
  PetTreatmentDto({
    required this.treatmentId,
    required this.petId,
    required this.treatment,
    required this.treatmentLastDate,
    required this.treatmentNextDate,
  });

  int treatmentId;
  int petId;
  String treatment;
  DateTime treatmentLastDate;
  DateTime treatmentNextDate;

  factory PetTreatmentDto.fromJson(String str) => PetTreatmentDto.fromMap(json.decode(str));

  factory PetTreatmentDto.fromMap(Map<String, dynamic> json) => PetTreatmentDto(
        treatmentId: json["treatmentId"],
        petId: json["petId"],
        treatment: json["treatment"],
        treatmentLastDate: DateTime.parse(json["treatmentLastDate"]),
        treatmentNextDate: DateTime.parse(json["treatmentNextDate"]),
      );
}
