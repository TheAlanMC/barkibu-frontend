import 'dart:convert';

class SymptomDto {
  SymptomDto({
    required this.symptomId,
    required this.symptom,
  });

  int symptomId;
  String symptom;

  factory SymptomDto.fromJson(String str) =>
      SymptomDto.fromMap(json.decode(str));

  factory SymptomDto.fromMap(Map<String, dynamic> json) => SymptomDto(
        symptomId: json["symptomId"],
        symptom: json["symptom"],
      );
}
