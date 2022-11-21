import 'dart:convert';

class VeterinarianQuestionFilterDto {
  VeterinarianQuestionFilterDto({
    required this.questionId,
    required this.petName,
    this.photoPath,
    required this.problem,
    required this.postedDate,
  });

  int questionId;
  String petName;
  String? photoPath;
  String problem;
  DateTime postedDate;

  factory VeterinarianQuestionFilterDto.fromJson(String str) => VeterinarianQuestionFilterDto.fromMap(json.decode(str));

  factory VeterinarianQuestionFilterDto.fromMap(Map<String, dynamic> json) => VeterinarianQuestionFilterDto(
        questionId: json["questionId"],
        petName: json["petName"],
        photoPath: json["photoPath"],
        problem: json["problem"],
        postedDate: DateTime.parse(json["postedDate"]),
      );
}