import 'dart:convert';

class VeterinarianRankingDto {
  VeterinarianRankingDto({
    required this.monthlyRanking,
    required this.generalRanking,
  });

  int monthlyRanking;
  int generalRanking;

  factory VeterinarianRankingDto.fromJson(String str) => VeterinarianRankingDto.fromMap(json.decode(str));

  factory VeterinarianRankingDto.fromMap(Map<String, dynamic> json) => VeterinarianRankingDto(
        monthlyRanking: json["monthlyRanking"],
        generalRanking: json["generalRanking"],
      );
}
