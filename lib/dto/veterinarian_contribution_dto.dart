import 'dart:convert';

class VeterinarianContributionDto {
  VeterinarianContributionDto({
    required this.totalAnswers,
    required this.specie,
  });

  int totalAnswers;
  String specie;

  factory VeterinarianContributionDto.fromJson(String str) => VeterinarianContributionDto.fromMap(json.decode(str));

  factory VeterinarianContributionDto.fromMap(Map<String, dynamic> json) => VeterinarianContributionDto(
        totalAnswers: json["totalAnswers"],
        specie: json["specie"],
      );
}
