import 'dart:convert';

import 'package:barkibu/utils/utils.dart';

class VeterinarianOwnAnswerDto {
  VeterinarianOwnAnswerDto({
    required this.petName,
    this.photoPath,
    required this.question,
    required this.answer,
    required this.totalLikes,
    required this.answerDate,
  });

  String petName;
  String? photoPath;
  String question;
  String answer;
  int totalLikes;
  DateTime answerDate;

  factory VeterinarianOwnAnswerDto.fromJson(String str) => VeterinarianOwnAnswerDto.fromMap(json.decode(str));

  factory VeterinarianOwnAnswerDto.fromMap(Map<String, dynamic> json) => VeterinarianOwnAnswerDto(
        petName: json["petName"],
        photoPath: json["photoPath"],
        question: json["question"],
        answer: json["answer"],
        totalLikes: json["totalLikes"],
        answerDate: DateTime.parse(json["answerDate"]),
      );
  Future<void> validatePhotoPath() async {
    if (photoPath != null) {
      photoPath = await Validator.validatePhotoPath(photoPath!);
    }
  }
}
