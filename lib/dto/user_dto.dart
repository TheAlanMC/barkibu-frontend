import 'dart:convert';

import 'package:barkibu/utils/utils.dart';

class UserDto {
  UserDto({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
   
  });

  String firstName;
  String lastName;
  String userName;
  String email;

  factory UserDto.fromJson(String str) => UserDto.fromMap(json.decode(str));

  factory UserDto.fromMap(Map<String, dynamic> json) => UserDto(
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        email: json["email"],
      );

  copyWith({
    String? firstName,
    String? lastName,
    String? userName,
    String? email,

  }) {
    return UserDto(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }

}