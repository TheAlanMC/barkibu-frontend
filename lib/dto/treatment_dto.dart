import 'dart:convert';

class TreatmentDto {
  TreatmentDto({
    required this.treatmentId,
    required this.treatment,
    required this.description,
  });

  int treatmentId;
  String treatment;
  String description;

  factory TreatmentDto.fromJson(String str) => TreatmentDto.fromMap(json.decode(str));

  factory TreatmentDto.fromMap(Map<String, dynamic> json) => TreatmentDto(
        treatmentId: json["treatmentId"],
        treatment: json["treatment"],
        description: json["description"],
      );
}
