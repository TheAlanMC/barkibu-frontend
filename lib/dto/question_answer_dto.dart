import 'dart:convert';

class QuestionAnswerDto {
  QuestionAnswerDto({
    required this.answerId,
    required this.liked,
    required this.answered,
    required this.veterinarianFirstName,
    required this.veterinarianLastName,
    required this.answer,
    required this.totalLikes,
    required this.answerDate,
  });

  int answerId;
  bool liked;
  bool answered;
  String veterinarianFirstName;
  String veterinarianLastName;
  String answer;
  int totalLikes;
  DateTime answerDate;

  factory QuestionAnswerDto.fromJson(String str) => QuestionAnswerDto.fromMap(json.decode(str));

  factory QuestionAnswerDto.fromMap(Map<String, dynamic> json) => QuestionAnswerDto(
        answerId: json["answerId"],
        liked: json["liked"],
        answered: json["answered"],
        veterinarianFirstName: json["veterinarianFirstName"],
        veterinarianLastName: json["veterinarianLastName"],
        answer: json["answer"],
        totalLikes: json["totalLikes"],
        answerDate: DateTime.parse(json["answerDate"]),
      );
}
