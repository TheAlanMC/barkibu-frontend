import 'dart:convert';

class UserPetOwnerDto {
  UserPetOwnerDto({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
  });

  String firstName;
  String lastName;
  String userName;
  String email;

  factory UserPetOwnerDto.fromJson(String str) => UserPetOwnerDto.fromMap(json.decode(str));

  factory UserPetOwnerDto.fromMap(Map<String, dynamic> json) => UserPetOwnerDto(
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        email: json["email"],
      );
}
