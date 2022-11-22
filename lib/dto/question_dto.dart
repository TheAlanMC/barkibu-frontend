import 'dart:convert';

import 'package:barkibu/utils/utils.dart';

class QuestionDto {
  QuestionDto({
    required this.questionId,
    required this.petName,
    this.photoPath,
    required this.problem,
    required this.description,
    required this.postedDate,
  });

  int questionId;
  String petName;
  String? photoPath;
  String problem;
  String description;
  DateTime postedDate;

  factory QuestionDto.fromJson(String str) => QuestionDto.fromMap(json.decode(str));

  factory QuestionDto.fromMap(Map<String, dynamic> json) => QuestionDto(
        questionId: json["questionId"],
        petName: json["petName"],
        photoPath: json["photoPath"],
        problem: json["problem"],
        description: json["description"],
        postedDate: DateTime.parse(json["postedDate"]),
      );

  Future<void> validatePhotoPath() async {
    if (photoPath != null) {
      photoPath = await Validator.validatePhotoPath(photoPath!);
    }
  }
}
