import 'dart:convert';

class CountryDto {
  CountryDto({
    required this.countryId,
    required this.country,
  });

  int countryId;
  String country;

  factory CountryDto.fromJson(String str) => CountryDto.fromMap(json.decode(str));

  factory CountryDto.fromMap(Map<String, dynamic> json) => CountryDto(
        countryId: json["countryId"],
        country: json["country"],
      );
}
