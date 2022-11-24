import 'dart:convert';

class PetDto {
  PetDto({
    required this.name,
    required this.gender,
    required this.breedId,
    required this.specieId,
    required this.castrated,
    required this.bornDate,
    this.chipNumber,
    this.photoPath,
  });

  String name;
  String gender;
  int breedId;
  int specieId;
  bool castrated;
  DateTime bornDate;
  String? chipNumber;
  String? photoPath;

  factory PetDto.fromJson(String str) => PetDto.fromMap(json.decode(str));

  factory PetDto.fromMap(Map<String, dynamic> json) => PetDto(
        name: json["name"],
        gender: json["gender"],
        breedId: json["breedId"],
        specieId: json["specieId"],
        castrated: json["castrated"],
        bornDate: DateTime.parse(json["bornDate"]),
        chipNumber: json["chipNumber"],
        photoPath: json["photoPath"],
      );
}
