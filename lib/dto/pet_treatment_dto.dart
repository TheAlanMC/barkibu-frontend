// To parse this JSON data, do
//
//     final petTreatmentDto = petTreatmentDtoFromMap(jsonString);

import 'dart:convert';

class PetTreatmentDto {
  PetTreatmentDto({
    required this.petTreatmentId,
    required this.treatmentId,
    required this.petId,
    required this.treatmentLastDate,
    required this.treatmentNextDate,
  });

  int petTreatmentId;
  int treatmentId;
  int petId;
  DateTime treatmentLastDate;
  DateTime treatmentNextDate;

  factory PetTreatmentDto.fromJson(String str) => PetTreatmentDto.fromMap(json.decode(str));

  factory PetTreatmentDto.fromMap(Map<String, dynamic> json) => PetTreatmentDto(
        petTreatmentId: json["petTreatmentId"],
        treatmentId: json["treatmentId"],
        petId: json["petId"],
        treatmentLastDate: DateTime.parse(json["treatmentLastDate"]),
        treatmentNextDate: DateTime.parse(json["treatmentNextDate"]),
      );
}
