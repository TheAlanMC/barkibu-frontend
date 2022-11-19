// To parse this JSON data, do
//
//     final petTreatmentDto = petTreatmentDtoFromMap(jsonString);

import 'dart:convert';

class VeterinarianInfoDto {
  VeterinarianInfoDto({
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.state,
    required this.country,
    required this.description,
    required this.photoPath,
  });

  String firstName;
  String lastName;
  String city;
  String state;
  String country;
  String description;
  String photoPath;

  factory VeterinarianInfoDto.fromJson(String str) => VeterinarianInfoDto.fromMap(json.decode(str));

  factory VeterinarianInfoDto.fromMap(Map<String, dynamic> json) => VeterinarianInfoDto(
        firstName: json["firstName"],
        lastName: json["lastName"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        description: json["description"],
        photoPath: json["photoPath"],
      );
}
