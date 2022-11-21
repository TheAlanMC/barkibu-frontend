import 'dart:convert';

class CityDto {
  CityDto({
    required this.stateId,
    required this.state,
    required this.countryId,
  });

  int stateId;
  String state;
  int countryId;

  factory CityDto.fromJson(String str) => CityDto.fromMap(json.decode(str));

  factory CityDto.fromMap(Map<String, dynamic> json) => CityDto(
        stateId: json["stateId"],
        state: json["state"],
        countryId: json["countryId"],
      );
}
