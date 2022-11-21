import 'dart:convert';

class StateDto {
  StateDto({
    required this.stateId,
    required this.state,
    required this.countryId,
  });

  int stateId;
  String state;
  int countryId;

  factory StateDto.fromJson(String str) => StateDto.fromMap(json.decode(str));

  factory StateDto.fromMap(Map<String, dynamic> json) => StateDto(
        stateId: json["stateId"],
        state: json["state"],
        countryId: json["countryId"],
      );
}
