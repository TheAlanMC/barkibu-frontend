// To parse this JSON data, do
//
//     final petTreatmentDto = petTreatmentDtoFromMap(jsonString);

import 'dart:convert';

class VeterinarianReputationDto {
  VeterinarianReputationDto({
    required this.totalAnswers,
    required this.totalPetOwnerLike,
    required this.totalVeterinarianLike,
  });

  int totalAnswers;
  int totalPetOwnerLike;
  int totalVeterinarianLike;

  factory VeterinarianReputationDto.fromJson(String str) => VeterinarianReputationDto.fromMap(json.decode(str));

  factory VeterinarianReputationDto.fromMap(Map<String, dynamic> json) => VeterinarianReputationDto(
        totalAnswers: json["totalAnswers"],
        totalPetOwnerLike: json["totalPetOwnerLike"],
        totalVeterinarianLike: json["totalVeterinarianLike"],
      );
}
