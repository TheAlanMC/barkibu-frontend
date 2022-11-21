import 'dart:convert';

class SpecieDto {
  SpecieDto({
    required this.specieId,
    required this.specie,
  });

  int specieId;
  String specie;

  factory SpecieDto.fromJson(String str) => SpecieDto.fromMap(json.decode(str));

  factory SpecieDto.fromMap(Map<String, dynamic> json) => SpecieDto(
        specieId: json["specieId"],
        specie: json["specie"],
      );
}
