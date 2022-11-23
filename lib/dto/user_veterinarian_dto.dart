import 'dart:convert';

import 'package:barkibu/utils/utils.dart';

class UserVeterinarianDto {
  UserVeterinarianDto({
    required this.firstName,
    required this.lastName,
    this.cityId,
    this.stateId,
    this.countryId,
    required this.userName,
    required this.email,
    this.description,
    this.photoPath,
  });

  String firstName;
  String lastName;
  int? cityId;
  int? stateId;
  int? countryId;
  String userName;
  String email;
  String? description;
  String? photoPath;

  factory UserVeterinarianDto.fromJson(String str) => UserVeterinarianDto.fromMap(json.decode(str));

  factory UserVeterinarianDto.fromMap(Map<String, dynamic> json) => UserVeterinarianDto(
        firstName: json["firstName"],
        lastName: json["lastName"],
        cityId: json["cityId"],
        stateId: json["stateId"],
        countryId: json["countryId"],
        userName: json["userName"],
        email: json["email"],
        description: json["description"],
        photoPath: json["photoPath"],
      );

  copyWith({
    String? firstName,
    String? lastName,
    int? cityId,
    int? stateId,
    int? countryId,
    String? userName,
    String? email,
    String? description,
    String? photoPath,
  }) {
    return UserVeterinarianDto(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      cityId: cityId ?? this.cityId,
      stateId: stateId ?? this.stateId,
      countryId: countryId ?? this.countryId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      description: description ?? this.description,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  Future<void> validatePhotoPath() async {
    if (photoPath != null) {
      photoPath = await ValidatorUtil.validatePhotoPath(photoPath!);
    }
  }
}
