import 'dart:convert';

class RegisterUserRequestDto {
  RegisterUserRequestDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userName,
    required this.password,
    required this.confirmPassword,
  });

  String firstName;
  String lastName;
  String email;
  String userName;
  String password;
  String confirmPassword;

  factory RegisterUserRequestDto.fromJson(String str) => RegisterUserRequestDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterUserRequestDto.fromMap(Map<String, dynamic> json) => RegisterUserRequestDto(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        userName: json["userName"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "userName": userName,
        "password": password,
        "confirmPassword": confirmPassword,
      };
}
