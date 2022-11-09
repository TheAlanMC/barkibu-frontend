import 'dart:convert';

class LoginResponseDto {
  LoginResponseDto({
    required this.result,
    required this.statusCode,
    required this.errorDetail,
  });

  Result result;
  String statusCode;
  dynamic errorDetail;

  factory LoginResponseDto.fromJson(String str) => LoginResponseDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseDto.fromMap(Map<String, dynamic> json) => LoginResponseDto(
        result: Result.fromMap(json["result"]),
        statusCode: json["statusCode"],
        errorDetail: json["errorDetail"],
      );

  Map<String, dynamic> toMap() => {
        "result": result.toMap(),
        "statusCode": statusCode,
        "errorDetail": errorDetail,
      };
}

class Result {
  Result({
    required this.token,
    required this.refreshToken,
  });

  String token;
  String refreshToken;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "refreshToken": refreshToken,
      };
}
