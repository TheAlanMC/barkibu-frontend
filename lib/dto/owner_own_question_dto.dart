import 'dart:convert';

class OwnerOwnQuestionDto {
  OwnerOwnQuestionDto({
    required this.questionId,
    required this.photoPath,
    required this.problem,
    required this.detailedDescription,
    required this.questionDate,
  });

  int questionId;
  String photoPath;
  String problem;
  String detailedDescription;
  DateTime questionDate;

  OwnerOwnQuestionDto fromJson(String str) => OwnerOwnQuestionDto.fromMap(json.decode(str));

  factory OwnerOwnQuestionDto.fromMap(Map<String, dynamic> json) => OwnerOwnQuestionDto(
        questionId: json["questionId"],
        photoPath: json["photoPath"],
        problem: json["problem"],
        detailedDescription: json["detailedDescription"],
        questionDate: DateTime.parse(json["questionDate"]),
      );
}
