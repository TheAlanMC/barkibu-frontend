// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:barkibu/utils/utils.dart';

class VeterinarianInfoDto {
  VeterinarianInfoDto({
    required this.firstName,
    required this.lastName,
    this.city,
    this.state,
    this.country,
    this.description,
    this.photoPath,
  });

  String firstName;
  String lastName;
  String? city;
  String? state;
  String? country;
  String? description;
  String? photoPath;

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

  Future<void> validatePhotoPath() async {
    this.photoPath = await Validator.validatePhotoPath(this.photoPath!);
  }
}
