import 'dart:convert';

import 'package:barkibu/utils/utils.dart';

class PetInfoDto {
  PetInfoDto({
    required this.petId,
    required this.name,
    required this.specie,
    required this.breed,
    this.photoPath,
    required this.bornDate,
    this.chipNumber,
  });

  int petId;
  String name;
  String specie;
  String breed;
  String? photoPath;
  DateTime bornDate;
  String? chipNumber;

  factory PetInfoDto.fromJson(String str) => PetInfoDto.fromMap(json.decode(str));

  factory PetInfoDto.fromMap(Map<String, dynamic> json) => PetInfoDto(
        petId: json["petId"],
        name: json["name"],
        specie: json["specie"],
        breed: json["breed"],
        photoPath: json["photoPath"],
        bornDate: DateTime.parse(json["born_date"]),
        chipNumber: json["chip_number"],
      );

  Future<void> validatePhotoPath() async {
    if (photoPath != null) {
      photoPath = await ValidatorUtil.validatePhotoPath(photoPath!);
    }
  }
}