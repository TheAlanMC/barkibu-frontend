import 'dart:convert';

class ResponseDto<T> {
  final T? result;
  final String statusCode;
  final String? errorDetail;

  ResponseDto({
    this.result,
    required this.statusCode,
    this.errorDetail,
  });

  factory ResponseDto.fromJson(String str) => ResponseDto.fromMap(json.decode(utf8.decode(str.runes.toList())));

  factory ResponseDto.fromMap(Map<String, dynamic> json) => ResponseDto(
        result: json["result"],
        statusCode: json["statusCode"],
        errorDetail: json["errorDetail"],
      );
}
