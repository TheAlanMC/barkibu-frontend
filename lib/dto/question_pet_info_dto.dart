import 'dart:convert';

class QuestionPetInfoDto {
  QuestionPetInfoDto({
    required this.specie,
    required this.breed,
    required this.gender,
    required this.bornDate,
    required this.castrated,
    required this.symptoms,
  });

  String specie;
  String breed;
  String gender;
  DateTime bornDate;
  bool castrated;
  List<String> symptoms;

  factory QuestionPetInfoDto.fromJson(String str) => QuestionPetInfoDto.fromMap(json.decode(str));

  factory QuestionPetInfoDto.fromMap(Map<String, dynamic> json) => QuestionPetInfoDto(
        specie: json["specie"],
        breed: json["breed"],
        gender: json["gender"],
        bornDate: DateTime.parse(json["bornDate"]),
        castrated: json["castrated"],
        symptoms: List<String>.from(json["symptoms"].map((x) => x)),
      );
}
