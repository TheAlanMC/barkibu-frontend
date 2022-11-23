// To parse this JSON data, do
//
//     final breedDto = breedDtoFromMap(jsonString);

import 'dart:convert';

class BreedDto {
  BreedDto({
    required this.breedId,
    required this.specieId,
    required this.breed,
  });

  int breedId;
  int specieId;
  String breed;

  factory BreedDto.fromJson(String str) => BreedDto.fromMap(json.decode(str));

  factory BreedDto.fromMap(Map<String, dynamic> json) => BreedDto(
        breedId: json["breedId"],
        specieId: json["specieId"],
        breed: json["breed"],
      );
}
