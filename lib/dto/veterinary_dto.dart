import 'dart:convert';

class VeterinaryDto {
  VeterinaryDto({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  String name;
  String address;
  double latitude;
  double longitude;
  String description;

  factory VeterinaryDto.fromJson(String str) => VeterinaryDto.fromMap(json.decode(str));

  factory VeterinaryDto.fromMap(Map<String, dynamic> json) => VeterinaryDto(
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        description: json["description"],
      );
}
