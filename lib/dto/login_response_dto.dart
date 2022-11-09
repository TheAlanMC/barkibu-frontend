import 'dart:convert';

class LoginResponseDto {
  LoginResponseDto({
    required this.token,
    required this.refreshToken,
  });

  String token;
  String refreshToken;

  factory LoginResponseDto.fromJson(String str) => LoginResponseDto.fromMap(json.decode(str));

  factory LoginResponseDto.fromMap(Map<String, dynamic> json) => LoginResponseDto(
        token: json["token"],
        refreshToken: json["refreshToken"],
      );
}
