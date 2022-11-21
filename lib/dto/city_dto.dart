import 'dart:convert';

class CityDto {
  CityDto({
    required this.cityId,
    required this.city,
    required this.stateId,
  });

  int cityId;
  String city;
  int stateId;

  factory CityDto.fromJson(String str) => CityDto.fromMap(json.decode(str));

  factory CityDto.fromMap(Map<String, dynamic> json) => CityDto(
        cityId: json["cityId"],
        city: json["city"],
        stateId: json["stateId"],
      );
}
